export const libraryControllerSwagger = {
  paths: {
    "/library": {
      "post": {
        "summary": "Create File Entry",
        "description": "Create a new file entry with the provided information.",
        "tags": ["Library"],
        "requestBody": {
          "required": true,
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "name": {
                    "type": "string",
                    "description": "The name of the file entry."
                  },
                  "description": {
                    "type": "string",
                    "description": "The description of the file entry."
                  },
                  "languageId": {
                    "type": "integer",
                    "description": "The language ID associated with the file entry."
                  },
                  "categoryIds": {
                    "type": "array",
                    "items": {
                      "type": "integer"
                    },
                    "description": "An array of category IDs associated with the file entry."
                  },
                  "file": {
                    "type": "string",
                    "format": "binary",
                    "description": "The file to upload."
                  }
                },
                "required": ["name", "languageId", "categoryIds", "file"],

              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "File entry created successfully.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/FileEntryFullRes"
                }
              }
            }
          },
          "400": {
            "description": "Bad request, invalid request body.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error.",
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
        "summary": "Get File Entry List",
        "description": "Retrieve a list of file entries from the library.",
        "tags": [
          "Library"
        ],
        "parameters": [
          {
            "in": "query",
            "name": "languageId",
            "type": "integer",
            "required": false,
            "description": "Language ID filter"
          },
          {
            "in": "query",
            "name": "name",
            "type": "string",
            "required": false,
            "description": "Name filter"
          },
          {
            "in": "query",
            "name": "categoryIds",
            "type": "array",
            "items": {
              "type": "integer"
            },
            "required": false,
            "description": "Category IDs filter"
          }
        ],
        "responses": {
          "200": {
            "description": "List of File Entries",
            "schema": {
              "$ref": "#/components/schemas/ResponseListModel"
            }
          },
          "400": {
            "description": "Bad Request",
            "schema": {
              "$ref": "#/components/schemas/ErrorResponse"
            }
          }
        }
      }
    },
    "/library/{id}": {
      "get": {
        "summary": "Get a File Entry by ID",
        "description": "Retrieve a single file entry by its ID.",
        "tags": [
          "Library"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "type": "integer",
            "description": "ID of the file entry to retrieve"
          }
        ],
        "responses": {
          "200": {
            "description": "Successful response",
            "schema": {
              "$ref": "#/components/schemas/FileEntryFullRes"
            }
          },
          "400": {
            "description": "Bad Request",
            "schema": {
              "$ref": "#/components/schemas/ErrorResponse"
            }
          },
          "404": {
            "description": "FileEntry not found",
            "schema": {
              "$ref": "#/components/schemas/ErrorResponse"
            }
          }
        }
      },
      "delete": {
        "summary": "Delete a File Entry by ID",
        "description": "Delete a single file entry by its ID.",
        "tags": [
          "Library"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "type": "integer",
            "description": "ID of the file entry to delete"
          }
        ],
        "responses": {
          "200": {
            "description": "Successful deletion",
            "schema": {
              "type": "object",
              "properties": {
                "message": {
                  "type": "string",
                  "example": "File entry deleted successfully"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "schema": {
              "$ref": "#/components/schemas/ErrorResponse"
            }
          },
          "404": {
            "description": "FileEntry not found",
            "schema": {
              "$ref": "#/components/schemas/ErrorResponse"
            }
          }
        }
      }
    }
  },
  components: {
    schemas: {
      "CreateFileEntryReqBody": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "languageId": {
            "type": "integer"
          },
          "categoryIds": {
            "type": "array",
            "items": {
              "type": "integer"
            }
          }
        },
        "required": [
          "name",
          "languageId",
          "categoryIds"
        ]
      },
      "FileEntryFullRes": {
        "type": "object",
        "properties": {
          "id": {
            "type": "integer"
          },
          "name": {
            "type": "string"
          },
          "language": {
            "$ref": "#/components/schemas/LanguageResumedItem"
          },
          "file": {
            "type": "string"
          },
          "thumbnail": {
            "type": "string"
          },
          "totalViews": {
            "type": "integer"
          },
          "totalDownloads": {
            "type": "integer"
          },
          "categories": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CategoryResumedRes"
            }
          },
          "description": {
            "type": "string"
          }
        }
      }
    }
  },

}