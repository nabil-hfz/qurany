export const accountServiceControllerSwagger = {
  "paths": {
    "/account/register": {
      "post": {
        "summary": "Register a new user account",
        "description": "Registers a new user account with the provided details and an optional profile image.",
        "tags": ["Account"],
        "requestBody": {
          "required": true,
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "email": {
                    "type": "string",
                    "format": "email",
                    "description": "The email address of the user."
                  },
                  "password": {
                    "type": "string",
                    "format": "password",
                    "description": "The user's password."
                  },
                  "displayName": {
                    "type": "string",
                    "description": "The display name of the user."
                  },
                  "phoneNumber": {
                    "type": "string",
                    "nullable": true,
                    "description": "The phone number of the user."
                  },
                  "image": {
                    "type": "string",
                    "format": "binary",
                    "nullable": true,
                    "description": "Profile image of the user."
                  }
                },
                "required": ["email", "password"]
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "User registered successfully.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreateAccountResBody"
                }
              }
            }
          },
          "400": {
            "description": "Bad request, validation failed for the provided request body.",
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
      }
    },
    "/account/login": {
      "post": {
        "summary": "Log in a user",
        "description": "Logs in a user with email and password.",
        "tags": ["Account"],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "type": "object",
                "properties": {
                  "email": {
                    "type": "string",
                    "format": "email",
                    "description": "The email address of the user."
                  },
                  "password": {
                    "type": "string",
                    "format": "password",
                    "description": "The user's password."
                  }
                },
                "required": ["email", "password"]
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "User logged in successfully.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/UserAccountResBody"
                }
              }
            }
          },
          "400": {
            "description": "Bad request, incorrect email or password.",
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
      }
    }
  },
  "components": {
    "schemas": {
      "CreateAccountResBody": {
        "type": "object",
        "properties": {
          "uid": {
            "type": "integer",
            "description": "Unique identifier of the newly created user."
          }
        }
      },
      "UserAccountResBody": {
        "type": "object",
        "properties": {
          "token": {
            "type": "string",
            "description": "Authentication token for the user."
          },
          "profile": {
            "type": "object",
            "properties": {
              "uid": {
                "type": "integer",
                "description": "Unique identifier of the user."
              },
              "email": {
                "type": "string",
                "description": "Email address of the user."
              },
              "displayName": {
                "type": "string",
                "description": "Display name of the user."
              },
              "photo": {
                "type": "string",
                "format": "uri",
                "nullable": true,
                "description": "URL of the user's profile photo."
              },
              "phoneNumber": {
                "type": "string",
                "nullable": true,
                "description": "Phone number of the user."
              },
              "customClaims": {
                "type": "object",
                "additionalProperties": true,
                "description": "Custom claims associated with the user."
              }
            }
          }
        }
      }
    }
  }
};
