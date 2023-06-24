const { ApolloServer } = require('apollo-server');
const { ApolloGateway, RemoteGraphQLDataSource } = require('@apollo/gateway');
const { readFileSync } = require('fs');
const supergraphSdl = readFileSync('./supergraph.graphql').toString();
const { ApolloLogPlugin } = require('apollo-log');
const plugins = [ApolloLogPlugin];
const {FileUploadDataSource} = require('@profusion/apollo-federation-upload');
const { expressMiddleware } = require('@apollo/server/express4');
const cors = require('cors');
import { json } from 'body-parser';
const express = require('express');

const gateway = new ApolloGateway({
    supergraphSdl,
    buildService({ url }) {
      return new RemoteGraphQLDataSource({
        url,
        willSendRequest({ request, context }) {
          request.http.headers.set("Authorization", " " + context.authorizationHeader);
          request.http.headers.set('Access-Control-Allow-Credentials', 'true');
          request.http.headers.set(
            'Access-Control-Allow-Origin',
            'https://studio.apollographql.com'
          );
          request.http.headers.set(
            'Access-Control-Allow-Headers',
            'Origin, X-Requested-With, Content-Type, Accept'
          );
        }
      });
    },
    uploadService: ({ url }) => new FileUploadDataSource({ 
      url, useChunkedTransfer: true }),
      useChunkedTransfer: true,
});

const app = express();

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
  const { url } = await server.listen();

// Specify the path where we'd like to mount our server
  app.use('/graphql', cors(), json(), expressMiddleware(server))

  console.log(`🚀  Server ready at ${url}`);
};

runServer().catch(error => {
  console.error('💥  Failed to start server:', error);
  process.exit(1);
});