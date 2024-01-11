export const libraryControllerSwagger = {
  paths: {
    "/library": {
      "post": {
        "summary": "Create a File Entry",
        "description": "Endpoint to create a new file entry in the library.",
        "tags": [
          "Library"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/CreateFileEntryReqBody"
            }
          },
          {
            "in": "formData",
            "name": "file",
            "type": "file",
            "required": true,
            "description": "File to be uploaded"
          }
        ],
        "responses": {
          "200": {
            "description": "File Entry Created Successfully",
            "schema": {
              "$ref": "#/definitions/FileEntryFullRes"
            }
          },
          "400": {
            "description": "Bad Request",
            "schema": {
              "$ref": "#/definitions/ErrorResponse"
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
              "$ref": "#/definitions/ResponseListModel"
            }
          },
          "400": {
            "description": "Bad Request",
            "schema": {
              "$ref": "#/definitions/ErrorResponse"
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
              "$ref": "#/definitions/FileEntryFullRes"
            }
          },
          "400": {
            "description": "Bad Request",
            "schema": {
              "$ref": "#/definitions/ErrorResponse"
            }
          },
          "404": {
            "description": "FileEntry not found",
            "schema": {
              "$ref": "#/definitions/ErrorResponse"
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
              "$ref": "#/definitions/ErrorResponse"
            }
          },
          "404": {
            "description": "FileEntry not found",
            "schema": {
              "$ref": "#/definitions/ErrorResponse"
            }
          }
        }
      }
    }
  },
  components: {
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
          "$ref": "#/definitions/LanguageResumedItem"
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
            "$ref": "#/definitions/Category"
          }
        },
        "description": {
          "type": "string"
        }
      }
    }
  }
}