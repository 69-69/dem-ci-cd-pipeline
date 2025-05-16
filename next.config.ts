import type {NextConfig} from "next";

const nextConfig: NextConfig = {
    // reactStrictMode: true,
    /* config options here
      async rewrites() {
          return [
              {
                  source: '/:path*',
                  destination: '/:path*'
              },
              {
                  source: '/blog',
                  destination: 'http://localhost:4000/blog'
              },
              {
                  source: '/blog/:path*',
                  destination: 'http://localhost:4000/blog/:path*'
              }
          ]
      },
      */
    standalone: true,
};

export default nextConfig;
