const { GraphQLRequest } = require("apollo-server-express");
const FileUploadDataSource = require('@profusion/apollo-federation-upload').default;
import {PrintServiceDetails} from './lib';
export class AuthenticationAndUploadDataSource extends FileUploadDataSource {
    constructor(options:any){
      super(options)
    }
    willSendRequest({
      request,
      context,
    }: {
      request: typeof GraphQLRequest;
      context: any;
    }) {
      request.http.headers.append("Authorization", " " + context.authorizationHeader);
      PrintServiceDetails(request.http)
      return request;
    }
  }