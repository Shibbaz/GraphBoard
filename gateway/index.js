"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
var ApolloServer = require("apollo-server-express").ApolloServer;
var _a = require('@apollo/gateway'), ApolloGateway = _a.ApolloGateway, RemoteGraphQLDataSource = _a.RemoteGraphQLDataSource;
var readFileSync = require('fs').readFileSync;
var supergraphSdl = readFileSync('./supergraph.graphql').toString();
var ApolloLogPlugin = require('apollo-log').ApolloLogPlugin;
var plugins = [ApolloLogPlugin];
var FileUploadDataSource = require('@profusion/apollo-federation-upload').default;
var expressMiddleware = require('@apollo/server/express4').expressMiddleware;
var cors = require('cors');
var graphqlUploadExpress = require('graphql-upload').graphqlUploadExpress;
var express = require('express');
var gateway = new ApolloGateway({
    supergraphSdl: supergraphSdl,
    buildService: function (_a) {
        var url = _a.url;
        return new FileUploadDataSource({
            url: url,
            useChunkedTransfer: true
        });
    },
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
var app = express();
app.use(graphqlUploadExpress());
var runServer = function () { return __awaiter(void 0, void 0, void 0, function () {
    var server;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                server = new ApolloServer({
                    plugins: plugins,
                    gateway: gateway,
                    context: function (_a) {
                        var req = _a.req;
                        return {
                            serverRequest: req,
                            authorizationHeader: req.headers.authorization
                        };
                    },
                });
                return [4 /*yield*/, server.start()];
            case 1:
                _a.sent();
                server.applyMiddleware({ app: app, path: "/" });
                return [2 /*return*/, new Promise(function (resolve) {
                        app.listen(4000, resolve);
                    })]; // Specify the path where we'd like to mount our server
        }
    });
}); };
runServer().catch(function (error) {
    console.error('💥  Failed to start server:', error);
    process.exit(1);
});
