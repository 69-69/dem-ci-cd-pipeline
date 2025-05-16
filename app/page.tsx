import Link from 'next/link'

export default function Home() {
  return (
      <div>
        <h1>Steve Home</h1>
        <p>He loves coding and learning new technologies.</p>
        <p>He is currently working on a Next.js project.</p>
        <p>He is also interested in AI and machine learning.</p>
        <p>In his free time, he enjoys reading books and playing video games.</p>
        <Link href="/blog">Home to Blog</Link>
      </div>
  )
}
