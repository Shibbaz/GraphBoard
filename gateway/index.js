var ApolloServer = require('apollo-server').ApolloServer;
var ApolloGateway = require('@apollo/gateway').ApolloGateway;
var readFileSync = require('fs').readFileSync;
var supergraphSdl = readFileSync('./supergraph.graphql').toString();
var gateway = new ApolloGateway({
    supergraphSdl: supergraphSdl
});
var server = new ApolloServer({
    gateway: gateway,
});
server.listen().then(function (_a) {
    var url = _a.url;
    console.log("\uD83D\uDE80 Gateway ready at ".concat(url));
}).catch(function (err) { console.error(err); });
