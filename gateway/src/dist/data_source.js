"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
exports.__esModule = true;
exports.AuthenticationAndUploadDataSource = void 0;
var GraphQLRequest = require("apollo-server-express").GraphQLRequest;
var FileUploadDataSource = require('@profusion/apollo-federation-upload')["default"];
var lib_1 = require("./lib");
var AuthenticationAndUploadDataSource = /** @class */ (function (_super) {
    __extends(AuthenticationAndUploadDataSource, _super);
    function AuthenticationAndUploadDataSource(options) {
        return _super.call(this, options) || this;
    }
    AuthenticationAndUploadDataSource.prototype.willSendRequest = function (_a) {
        var request = _a.request, context = _a.context;
        request.http.headers.append("Authorization", " " + context.authorizationHeader);
        lib_1.PrintServiceDetails(request.http);
        return request;
    };
    return AuthenticationAndUploadDataSource;
}(FileUploadDataSource));
exports.AuthenticationAndUploadDataSource = AuthenticationAndUploadDataSource;
