import { User } from "../../entities/User";
import { elasticClient } from "../global/elasticClient"

export const addUserToElastic = async (user: User) => {
  // await elasticClient.indices.delete({index: "untitled_startup_test"});
  let indexExists: boolean = true;
  elasticClient.indices.exists({index: "untitled_startup_test"}, (err) => {
    if (err) {
      indexExists = false;
    }
  });
  if (!indexExists) {
    await elasticClient.indices.create({
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
          // users: {
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
          // }
        }
      }
    }, (err, res) => {
      console.log(err);
      console.log(res)
    });

    console.log("done");
  }

  const sapo = elasticClient.index({
    index: 'untitled_startup_test',
    id: `${user.id}`,
    // type: 'users',
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
    // refresh: 'true'
  }, (err, r) => {
    console.log('err: ' + err);
    console.log(r);
    console.log('res: ' + r);
    console.log(r)
  });

  console.log(sapo);
}

export const searchForUsers = async (search: string) => {
  // const indexes = await elasticClient.cat.indices({format: 'json'});
  // console.log(indexes)
  const body = await elasticClient.search({
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

  console.log(body.body.hits.hits)
  // console.log(body.hits)
  // console.log(body.hits.hits)
  
  let usersResponse: any[] = body.body.hits.hits;
  return usersResponse.map((item, i) => usersResponse[i] = item._source);
}

export const updateUser = async (doc: Object, userId: number) => {
  await elasticClient.update({
    index: 'untitled_startup_test',
    id: `${userId}`,
    body: {
      doc: doc
    }
  })

  const res = await elasticClient.get({
    index: 'untitled_startup_test',
    id: `${userId}`,
  })

  console.log(res)
}