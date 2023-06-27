const { expressMiddleware } = require('@apollo/server/express4');
const cors = require('cors');
const {graphqlUploadExpress} = require('graphql-upload')
import { json } from 'body-parser';
const express = require('express');
import {gateway} from './src/gateway'
const { ApolloServer } = require("apollo-server-express");


const app = express();
app.use(graphqlUploadExpress({ maxFileSize: 100000000, maxFiles: 10 }));

const runServer = async () => {
  const server = new ApolloServer({
    gateway,
    context: ({ req }:any) => {
      return {
        serverRequest: req,
        authorizationHeader: req.headers.authorization
      };
  },

  });
  await server.start();
  server.applyMiddleware({ app, path: "/" });

  return new Promise((resolve) => {
    app.listen(4000, resolve);
    console.log("🚀 Server is Successfully running on port 4000.")
  });
};

runServer().catch(error => {
  console.error('💥  Failed to start server:', error);
  process.exit(1);
});