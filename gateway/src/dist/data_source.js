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
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
exports.__esModule = true;
exports.AuthenticationAndUploadDataSource = void 0;
var apollo_federation_upload_1 = require("@profusion/apollo-federation-upload");
var AuthenticationAndUploadDataSource = /** @class */ (function (_super) {
    __extends(AuthenticationAndUploadDataSource, _super);
    function AuthenticationAndUploadDataSource(config) {
        var _this = _super.call(this, config) || this;
        var nativeFetcher = _this.fetcher;
        var newFetcher = function (url, options) {
            var _a;
            var plainHeaders = (options === null || options === void 0 ? void 0 : options.headers) || { '': '' };
            if ((_a = options === null || options === void 0 ? void 0 : options.headers) === null || _a === void 0 ? void 0 : _a.raw) {
                var headers = options.headers;
                plainHeaders = Object.fromEntries(headers);
            }
            return nativeFetcher(url, __assign(__assign({}, options), { headers: plainHeaders }));
        };
        _this.fetcher = newFetcher;
        return _this;
    }
    AuthenticationAndUploadDataSource.prototype.willSendRequest = function (_a) {
        var _b;
        var request = _a.request, context = _a.context;
        (_b = request === null || request === void 0 ? void 0 : request.http) === null || _b === void 0 ? void 0 : _b.headers.set("Authorization", " " + context.authorizationHeader);
    };
    AuthenticationAndUploadDataSource.prototype.didReceiveResponse = function (_a) {
        var response = _a.response, context = _a.context;
        return response;
    };
    return AuthenticationAndUploadDataSource;
}(apollo_federation_upload_1["default"]));
exports.AuthenticationAndUploadDataSource = AuthenticationAndUploadDataSource;
