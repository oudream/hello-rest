#!/usr/bin/env bash


# Get a full fake REST API with zero coding in less than 30 seconds (seriously)
https://github.com/typicode/json-server


# Apache CouchDB
https://github.com/apache/couchdb


# openapi swagger
https://github.com/swagger-api/swagger-ui
https://github.com/swagger-api/swagger-editor
https://github.com/swagger-api/swagger-codegen
https://github.com/OAI/OpenAPI-Specification
https://legacy.gitbook.com/book/huangwenchao/swagger/details
# express-openapi-validator
https://developer.ibm.com/recipes/tutorials/builds-apis-with-node-js-express-and-openapi-3/
https://github.com/cdimascio/express-openapi-validator


# REST API for any Postgres database https://postgrest.org
https://github.com/PostgREST/postgrest



### json-server validator
npm install -g json-server
cd ${hello-rest-path}
cat >> ./hello/json-server1/db.json <<EOF
{
  "posts": [
    { "id": 1, "title": "json-server", "author": "typicode" }
  ],
  "comments": [
    { "id": 1, "body": "some comment", "postId": 1 }
  ],
  "profile": { "name": "typicode" }
}
EOF

json-server --watch "./hello/json-server1/db.json"&
# \{^_^}/ hi!
#
#  Loading ./hello/json-server1/db.json
#  Done
#
#  Resources
#  http://localhost:3000/posts
#  http://localhost:3000/comments
#  http://localhost:3000/profile
#
#  Home
#  http://localhost:3000
#
#  Type s + enter at any time to create a snapshot of the database
#  Watching...
open  http://localhost:3000/posts/1
open  http://localhost:3000/posts


