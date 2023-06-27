const { readFileSync } = require('fs');
const supergraphSdl = readFileSync('./src/supergraph.graphql').toString();
const { ApolloGateway } = require('@apollo/gateway');
const {AuthenticationAndUploadDataSource} = require('./data_source')
import { FileUploadDataSourceArgs } from '@profusion/apollo-federation-upload/build/FileUploadDataSource';

export const gateway = new ApolloGateway({
    supergraphSdl,
    buildService({ url }: FileUploadDataSourceArgs) {
      return new AuthenticationAndUploadDataSource({
        url
      });
    }
});