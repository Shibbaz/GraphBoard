"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
var ApolloServer = require('apollo-server').ApolloServer;
var _a = require('@apollo/gateway'), ApolloGateway = _a.ApolloGateway, RemoteGraphQLDataSource = _a.RemoteGraphQLDataSource;
var readFileSync = require('fs').readFileSync;
var supergraphSdl = readFileSync('./supergraph.graphql').toString();
var gateway = new ApolloGateway({
    supergraphSdl: supergraphSdl,
});
var AuthenticatedDataSource = /** @class */ (function (_super) {
    __extends(AuthenticatedDataSource, _super);
    function AuthenticatedDataSource() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    AuthenticatedDataSource.prototype.willSendRequest = function (_a) {
        var request = _a.request, context = _a.context;
        request.http.headers.set("Authorization", request.context.Headers.authorization);
    };
    return AuthenticatedDataSource;
}(RemoteGraphQLDataSource));
var server = new ApolloServer({
    gateway: gateway,
    logger: console,
    context: function (_a) {
        var req = _a.req;
        return {
            serverRequest: req,
            Headers: req.headers
        };
    }
});
server.listen().then(function (_a) {
    var url = _a.url;
    console.log("\uD83D\uDE80 Gateway ready at ".concat(url));
}).catch(function (err) { console.error(err); });
