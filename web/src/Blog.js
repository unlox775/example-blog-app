import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Blog = () => {
    const [posts, setPosts] = useState([]);
    console.log(`posts: ${posts}`)

    useEffect(() => {
        axios.get('http://localhost:4000/api/posts')
            .then(response => {
                console.log(`response.data: ${response.data}`)
                setPosts(response.data);
            })
            .catch(error => {
                console.error(`Error fetching data: ${error}`);
            })
    }, []);

    return (
        <div>
            <h1>Blog Posts</h1>
            {posts.map(post => (
                <div key={post.id}>
                    <h2>{post.title}</h2>
                    <p>{post.body}</p>
                </div>
            ))}
        </div>
    );
};

export default Blog;
