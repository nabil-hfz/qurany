export const libraryCategoryControllerSwagger = {
  paths: {
    "/library/category": {
      post: {
        summary: "Create Categories",
        description: "Create multiple categories with the provided information.",
        tags: ["Category"],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: {
                type: "object",
                properties: {
                  categories: {
                    type: "array",
                    items: {
                      type: "object",
                      properties: {
                        ar: { type: "string" },
                        en: { type: "string" },
                      },
                      required: ["ar", "en"],
                    },
                  },
                },
                required: ["categories"],
              },
            },
          },
        },
        responses: {
          200: {
            description: "Categories created successfully.",
            content: {
              "application/json": {
                schema: {
                  type: "object",
                  properties: {
                    items: {
                      type: "array",
                      items: {
                        $ref: "#/components/schemas/CategoryResumedRes",
                      },
                      description: "A list of created categories.",
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

      get: {
        summary: "Get a list of categories",
        tags: ["Category"],
        parameters: [
          {
            $ref: "#/components/parameters/PageParam",
          },
          {
            $ref: "#/components/parameters/LimitParam",
          },
        ],
        responses: {
          200: {
            description: "Successful response with a list of categories.",
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
                        $ref: "#/components/schemas/CategoryResumedRes",
                      },
                      description: "A list of categories.",
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
    "/library/category/{categoryId}": {
      delete: {
        summary: "Delete a category by ID",
        tags: ["Category"],
        parameters: [
          {
            in: "path",
            name: "id",
            required: true,
            schema: {
              type: "string",
            },
            description: "The ID of the category to be deleted.",
          },
        ],
        responses: {
          200: {
            description: "Category deleted successfully.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/DeleteResponse",
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
            description: "Category not found error response.",
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

      CategoryResumedRes: {
        type: "object",
        properties: {
          id: {
            type: "integer",
            description: "The unique identifier of the category.",
          },
          name: {
            $ref: "#/components/schemas/LocalizedEntity",
            description: "The name of the category as a localized entity.",
          },
        },
      },


    }
  }
};
