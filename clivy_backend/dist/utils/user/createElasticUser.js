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
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateUser = exports.searchForUsers = exports.addUserToElastic = void 0;
const elasticClient_1 = require("../global/elasticClient");
const addUserToElastic = (user) => __awaiter(void 0, void 0, void 0, function* () {
    let indexExists = true;
    elasticClient_1.elasticClient.indices.exists({ index: "untitled_startup_test" }, (err) => {
        if (err) {
            indexExists = false;
        }
    });
    if (!indexExists) {
        yield elasticClient_1.elasticClient.indices.create({
            index: "untitled_startup_test",
            body: {
                settings: {
                    analysis: {
                        analyzer: {
                            custom_edge_ngram_analyzer: {
                                tokenizer: 'custom_edge_ngram_tokenizer',
                                filter: [
                                    'lowercase',
                                    'asciifolding'
                                ]
                            },
                            autocomplete_search: {
                                tokenizer: "standard",
                                filter: [
                                    "lowercase",
                                    "asciifolding"
                                ]
                            }
                        },
                        tokenizer: {
                            custom_edge_ngram_tokenizer: {
                                type: 'edge_ngram',
                                min_gram: 1,
                                max_gram: 30,
                                token_chars: [
                                    'letter',
                                    'digit',
                                    'punctuation',
                                    'symbol'
                                ]
                            }
                        }
                    }
                },
                mappings: {
                    properties: {
                        id: { type: 'text' },
                        username: {
                            type: 'text',
                            analyzer: 'custom_edge_ngram_analyzer',
                            search_analyzer: "autocomplete_search"
                        },
                        name: {
                            type: 'text',
                            analyzer: 'custom_edge_ngram_analyzer',
                            search_analyzer: 'autocomplete_search'
                        },
                        email: { type: 'text' },
                        file_key: { type: 'text' },
                        small_file_key: { type: 'text' },
                        createdAt: { type: 'text' },
                        updatedAt: { type: 'text' }
                    }
                }
            }
        }, (err, res) => {
            console.log(err);
            console.log(res);
        });
        console.log("done");
    }
    const sapo = elasticClient_1.elasticClient.index({
        index: 'untitled_startup_test',
        id: `${user.id}`,
        body: {
            id: `${user.id}`,
            username: user.username,
            name: user.name,
            email: user.email,
            file_key: user.file_key,
            small_file_key: user.small_file_key,
            createdAt: user.createdAt.getTime(),
            updatedAt: user.updatedAt.getTime()
        },
    }, (err, r) => {
        console.log('err: ' + err);
        console.log(r);
        console.log('res: ' + r);
        console.log(r);
    });
    console.log(sapo);
});
exports.addUserToElastic = addUserToElastic;
const searchForUsers = (search) => __awaiter(void 0, void 0, void 0, function* () {
    const body = yield elasticClient_1.elasticClient.search({
        index: 'untitled_startup_test',
        body: {
            from: 0,
            size: 20,
            query: {
                multi_match: {
                    query: search,
                    operator: "and",
                    fields: [
                        "username",
                        "name",
                    ],
                    fuzziness: 1
                }
            },
        }
    });
    console.log(body.body.hits.hits);
    let usersResponse = body.body.hits.hits;
    return usersResponse.map((item, i) => usersResponse[i] = item._source);
});
exports.searchForUsers = searchForUsers;
const updateUser = (doc, userId) => __awaiter(void 0, void 0, void 0, function* () {
    yield elasticClient_1.elasticClient.update({
        index: 'untitled_startup_test',
        id: `${userId}`,
        body: {
            doc: doc
        }
    });
    const res = yield elasticClient_1.elasticClient.get({
        index: 'untitled_startup_test',
        id: `${userId}`,
    });
    console.log(res);
});
exports.updateUser = updateUser;
//# sourceMappingURL=createElasticUser.js.map