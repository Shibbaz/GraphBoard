const { ApolloServer } = require('apollo-server');
const { ApolloGateway, RemoteGraphQLDataSource } = require('@apollo/gateway');
const { readFileSync } = require('fs');
const supergraphSdl = readFileSync('./supergraph.graphql').toString();
const { ApolloLogPlugin } = require('apollo-log');
const plugins = [ApolloLogPlugin];


const gateway = new ApolloGateway({
    supergraphSdl,
});

const server = new ApolloServer({
    gateway,
    plugins,
    context: ({ req }) => {
        return {
          serverRequest: req,
          Headers: {
            "Authorization": req.headers.authorization
          }
        };
    }
});

server.listen().then(({ url }) => {
    console.log(`🚀 Gateway ready at ${url}`);
}).catch(err => {console.error(err)});
