import {
  ApolloGateway,
  GraphQLDataSourceProcessOptions,
} from '@apollo/gateway';
import { Fetcher } from '@apollo/utils.fetcher';
import FileUploadDataSource from '@profusion/apollo-federation-upload';
import { FileUploadDataSourceArgs } from '@profusion/apollo-federation-upload/build/FileUploadDataSource';
import { GraphQLResponse } from 'apollo-server-types';

export class AuthenticationAndUploadDataSource extends FileUploadDataSource {
  constructor(config: FileUploadDataSourceArgs) {
    super(config);
    const nativeFetcher = this.fetcher;
    const newFetcher: Fetcher = (url, options) => {
      let plainHeaders: Record<string, string> = options?.headers || { '': '' };
      if (options?.headers?.raw) {
        const headers = options.headers as unknown as IterableIterator<
          [string, string]
        >;
        plainHeaders = Object.fromEntries<string>(headers) as Record<
          string,
          string
        >;
      }
      return nativeFetcher(url, { ...options, headers: plainHeaders });
    };
    this.fetcher = newFetcher;
  }
  willSendRequest({ request, context }: GraphQLDataSourceProcessOptions) {
    request?.http?.headers.set("Authorization", " " + context.authorizationHeader);
  }
  didReceiveResponse({
    response,
    context,
  }: {
    response: GraphQLResponse;
    context: GraphQLDataSourceProcessOptions['context'];
  }) {
    return response;
  }
}