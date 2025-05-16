# syntax=docker/dockerfile:1

### Base image for all stages
FROM node:18-alpine AS base

# Needed for Playwright or native modules
RUN apk add --no-cache libc6-compat

WORKDIR /app

### Dependencies
FROM base AS deps
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* .npmrc* ./
RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i --frozen-lockfile; \
  else echo "No lockfile found." && exit 1; \
  fi

### Build stage (this defines "builder"!)
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN \
  if [ -f yarn.lock ]; then yarn build; \
  elif [ -f package-lock.json ]; then npm run build; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm run build; \
  else echo "No lockfile found." && exit 1; \
  fi

### Production runner
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Create system user
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs

# Copy only needed build output
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

RUN chown -R nextjs:nodejs /app
USER nextjs

EXPOSE 3000
CMD ["node", "server.js"]
