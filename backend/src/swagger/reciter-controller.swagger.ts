export const reciterControllerSwagger = {
  paths: {
    "/reciter": {
      post: {
        summary: "Create Reciter",
        description: "Create a new reciter with the provided information.",
        tags: ["Reciter"],
        requestBody: {
          required: true,
          content: {
            "multipart/form-data": {
              schema: {
                type: "object",
                properties: {
                  bio: {
                    type: "object",
                    properties: {
                      en: { type: "string" },
                      ar: { type: "string" }
                    },
                    required: ["en", "ar"]
                  },
                  reciterIndex: { type: "integer" },
                  name: {
                    type: "object",
                    properties: {
                      en: { type: "string" },
                      ar: { type: "string" }
                    },
                    required: ["en", "ar"]
                  },
                  numberOfKhatmat: { type: "integer" },
                  recitationTypes: {
                    type: "array",
                    items: { type: "integer" }
                  },
                  image: { type: "string", format: "binary" }
                },
                required: ["bio", "reciterIndex", "name", "numberOfKhatmat", "recitationTypes", "image"]
              },
            }
          }
        },
        responses: {
          200: {
            description: "Reciter created successfully.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/ReciterFullRes"
                }
              }
            }
          },
          400: {
            description: "Bad request, invalid request body.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          500: {
            description: "Internal server error.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/ErrorResponse"
                }
              }
            }
          }
        }
      },
      get: {
        summary: "Get a list of reciters",
        tags: ["Reciter"],
        parameters: [
          {
            $ref: "#/components/parameters/PageParam"
          },
          {
            $ref: "#/components/parameters/LimitParam"
          },
        ],
        responses: {
          200: {
            description: "Successful response with a list of reciters.",
            content: {
              "application/json": {
                schema: {
                  type: "object",
                  properties: {
                    message: {
                      type: "string",
                      description: "A message indicating the success of the operation.",
                    },
                    items: {
                      type: "array",
                      items: {
                        $ref: "#/components/schemas/ReciterResumedRes",
                      },
                      description: "A list of reciters.",
                    },
                  },
                },
              },
            },
          },
          400: {
            description: "Bad request error response.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/ErrorResponse",
                },
              },
            },
          },
        },
      },
    },
    "/reciter/{reciterId}": {
      get: {
        summary: "Get a reciter by ID",
        tags: ["Reciter"],
        parameters: [
          {
            in: "path",
            name: "reciterId",
            required: true,
            description: "The ID of the reciter to retrieve.",
            schema: {
              type: "integer",
            },
          },
        ],
        responses: {
          200: {
            description: "Successful response with the reciter details.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/ReciterFullRes",
                },
              },
            },
          },
          400: {
            description: "Bad request error response.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/ErrorResponse",
                },
              },
            },
          },
          404: {
            description: "Reciter not found error response.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/ErrorResponse",
                },
              },
            },
          },
        },
      },
    }
    
  },
  components: {
    schemas: {
      ReciterResumedRes: {
        type: "object",
        properties: {
          id: {
            type: "integer",
            description: "The unique identifier of the reciter.",
          },
          numberOfKhatmat: {
            type: "integer",
            description: "The number of khatmat associated with the reciter.",
          },
          name: {
            $ref: "#/components/schemas/LocalizedEntity",
            description: "The name of the reciter as a localized entity.",
          },
          image: {
            type: "string",
            nullable: true,
            description: "The URL of the reciter's image, if available.",
          },
        },
      },
      ReciterFullRes: {
        allOf: [
          {
            $ref: "#/components/schemas/ReciterResumedRes",
          },
          {
            type: "object",
            properties: {
              bio: {
                type: "object",
                properties: {
                  en: {
                    type: "string",
                    description: "The English biography of the reciter.",
                  },
                  ar: {
                    type: "string",
                    description: "The Arabic biography of the reciter.",
                  },
                },
                description: "The biography of the reciter in different languages.",
              },
              reciterIndex: {
                type: "integer",
                description: "The index of the reciter.",
              },
              recitationTypes: {
                type: "array",
                items: {
                  type: "integer",
                },
                description: "The types of recitations performed by the reciter.",
              },
            },
          },
        ],
      }
      
    }
  }
};
