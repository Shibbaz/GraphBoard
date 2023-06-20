var ApolloServer = require('apollo-server').ApolloServer;
var _a = require('@apollo/gateway'), ApolloGateway = _a.ApolloGateway, RemoteGraphQLDataSource = _a.RemoteGraphQLDataSource;
var readFileSync = require('fs').readFileSync;
var supergraphSdl = readFileSync('./supergraph.graphql').toString();
var ApolloLogPlugin = require('apollo-log').ApolloLogPlugin;
var plugins = [ApolloLogPlugin];
var gateway = new ApolloGateway({
    supergraphSdl: supergraphSdl,
    buildService: function (_a) {
        var url = _a.url;
        return new RemoteGraphQLDataSource({
            url: url,
            willSendRequest: function (_a) {
                var request = _a.request, context = _a.context;
                request.http.headers.set("Authorization", context.authorizationHeader);
            }
        });
    }
});
var server = new ApolloServer({
    gateway: gateway,
    context: function (_a) {
        var req = _a.req;
        return {
            serverRequest: req,
            authorizationHeader: req.headers.authorization
        };
    }
});
server.listen().then(function (_a) {
    var url = _a.url;
    console.log("\uD83D\uDE80 Gateway ready at ".concat(url));
}).catch(function (err) { console.error(err); });
