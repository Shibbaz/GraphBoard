"use strict";
exports.__esModule = true;
exports.gateway = void 0;
var readFileSync = require('fs').readFileSync;
var supergraphSdl = readFileSync('./src/supergraph.graphql').toString();
var ApolloGateway = require('@apollo/gateway').ApolloGateway;
var AuthenticationAndUploadDataSource = require('./data_source').AuthenticationAndUploadDataSource;
exports.gateway = new ApolloGateway({
    supergraphSdl: supergraphSdl,
    buildService: function (_a) {
        var name = _a.name, url = _a.url;
        return new AuthenticationAndUploadDataSource({
            url: url,
            useChunkedTransfer: true
        });
    }
});
