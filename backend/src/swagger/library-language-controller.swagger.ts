export const languageControllerSwagger = {
  "paths": {
    "/library/language": {
      "post": {
        "summary": "Create new languages",
        "description": "Allows the creation of multiple new languages.",
        "tags": ["Language"],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "type": "object",
                "required": ["languages"],
                "properties": {
                  "languages": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "description": "A list of language names to be created."
                  }
                }
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "A list of created languages.",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "properties": {
                    "items": {
                      "type": "array",
                      "items": {
                        "$ref": "#/components/schemas/LanguageResumedRes"
                      },
                      "description": "A list of created languages"
                    }
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad request. Missing or invalid fields in the request.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          }
        }
      },
      "get": {
        "summary": "Retrieve a list of languages",
        "description": "Get a list of all available languages.",
        "tags": ["Language"],
        "parameters": [
          { "$ref": "#/components/parameters/PageParam" },
          { "$ref": "#/components/parameters/LimitParam" }
        ],
        "responses": {
          "200": {
            "description": "A list of languages.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/LanguageResumedRes"
                }
              }
            }
          },
          "400": {
            "description": "Bad request. Error in retrieving the list."
            ,
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          }
        }
      }
    },
    "/library/language/{id}": {
      "delete": {
        "summary": "Delete a language by its ID",
        "description": "Deletes a language with the specified ID. Returns true if the deletion was successful.",
        "tags": ["Language"],
        "parameters": [
          {
            "in": "path",
            "name": "id",
            "required": true,
            "schema": {
              "type": "integer"
            },
            "description": "The ID of the language to be deleted."
          }
        ],
        "responses": {
          "200": {
            "description": "Successfully deleted the language.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DeleteResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad request. Invalid or missing ID in the request.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          "404": {
            "description": "Language not found with the given ID.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "LanguageResumedItem": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "Name of created language."
          },
          "id": {
            "type": "number",
            "format": "integer",
            "description": "Id of the created language."
          }
        }
      },
      "LanguageResumedRes": {
        "type": "object",
        "properties": {
          "items": {
            "type": "array",
            "description": "A list of created languages.",
            "items": {
              "$ref": "#/components/schemas/LanguageResumedItem"
            }
          },
        }
      },
    }
  }
};
