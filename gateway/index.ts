const { ApolloServer } = require("apollo-server-express");
const { ApolloGateway, RemoteGraphQLDataSource } = require('@apollo/gateway');
const { readFileSync } = require('fs');
const supergraphSdl = readFileSync('./supergraph.graphql').toString();
const { ApolloLogPlugin } = require('apollo-log');
const plugins = [ApolloLogPlugin];
const FileUploadDataSource = require('@profusion/apollo-federation-upload').default;
const { expressMiddleware } = require('@apollo/server/express4');
const cors = require('cors');
const {graphqlUploadExpress} = require('graphql-upload')
import { json } from 'body-parser';
const express = require('express');

const gateway = new ApolloGateway({
    supergraphSdl,
    buildService: ({ url }) =>
      new FileUploadDataSource({
        url,
        useChunkedTransfer: true
      }),
  /**
    buildService({ url }) {
      return new RemoteGraphQLDataSource({
        url,
        willSendRequest({ request, context }) {
          request.http.headers.set("Authorization", " " + context.authorizationHeader);
        }
      });
    }  
  */    
});

const app = express();
app.use(graphqlUploadExpress());

const runServer = async () => {
  const server = new ApolloServer({
    plugins,
    gateway,
    context: ({ req }) => {
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
  });// Specify the path where we'd like to mount our server

  app.catch(console.error);

};

runServer().catch(error => {
  console.error('💥  Failed to start server:', error);
  process.exit(1);
});