const { readFileSync } = require('fs');
const supergraphSdl = readFileSync('./src/supergraph.graphql').toString();
const { ApolloGateway } = require('@apollo/gateway');
const {AuthenticationAndUploadDataSource} = require('./data_source')

export const gateway = new ApolloGateway({
    supergraphSdl,
    buildService({ name, url }:any) {
      return new AuthenticationAndUploadDataSource({
        url,
        useChunkedTransfer: true,
      });
    }
});