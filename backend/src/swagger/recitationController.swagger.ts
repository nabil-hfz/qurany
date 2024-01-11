export const recitationControllerSwagger = {
  paths: {
    "/recitation": {
      post: {
        summary: "Create Recitations",
        description: "Creates new recitations with the given details.",
        tags: ["Recitation"],
        requestBody: {
          required: true,
          content: {
            "multipart/form-data": {
              schema: {
                type: "object",
                properties: {
                  khatmaId: {
                    type: "integer",
                    description: "ID of the khatma for which to create recitations.",
                    nullable: false,
                    required: true,
                  },
                  sequence: {
                    type: "integer",
                    description: "Sequence number for the recitations."
                  },
                  audios: {
                    type: "array",
                    items: {
                      type: "string",
                      format: "binary"
                    },
                    minItems: 1,
                    description: "Audio files (at least one audio file required)."
                  },
                  images: {
                    type: "array",
                    items: {
                      type: "string",
                      format: "binary"
                    },
                    minItems: 1,
                    description: "Image files (at least one image file required)."
                  }
                },
                required: ["khatmaId", "sequence", "audios", "images"]
              }
            }
          }
        },
        responses: {
          200: {
            description: "Recitations created successfully.",
            content: {
              "application/json": {
                schema: {
                  type: "object",
                  properties: {
                    message: {
                      type: "string",
                      description: "Success message."
                    },
                    items: {
                      type: "array",
                      items: {
                        $ref: "#/components/schemas/RecitationFullRes"
                      }
                    }
                  }
                }
              }
            }
          },
          400: {
            description: "Bad request, khatmaId is missing or invalid.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          404: {
            description: "Khatma not found with the provided khatmaId.",
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
        summary: "Get Recitation List",
        description: "Retrieve a list of recitations with optional filtering by reciter ID or khatma ID.",
        tags: ["Recitation"],
        parameters: [
          {
            in: "query",
            name: "reciterId",
            schema: {
              type: "integer"
            },
            required: false,
            description: "ID of the reciter to filter the recitations."
          },
          {
            in: "query",
            name: "khatmaId",
            schema: {
              type: "integer"
            },
            required: false,
            description: "ID of the khatma to filter the recitations."
          },
          {
            $ref: "#/components/parameters/PageParam"
          },
          {
            $ref: "#/components/parameters/LimitParam"
          }
        ],
        responses: {
          200: {
            description: "A list of recitations.",
            content: {
              "application/json": {
                schema: {
                  type: "object",
                  properties: {
                    items: {
                      type: "array",
                      items: {
                        $ref: "#/components/schemas/RecitationResumedRes"
                      }
                    }
                  }
                }
              }
            }
          },
          400: {
            description: "Bad request, invalid parameters provided.",
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
      }

    },
    "/recitation/{recitationId}": {
      get: {
        summary: "Get Recitation by ID",
        description: "Retrieve detailed information about a specific recitation using its ID.",
        tags: ["Recitation"],
        parameters: [
          {
            in: "path",
            name: "recitationId",
            schema: {
              type: "integer"
            },
            required: true,
            description: "The ID of the recitation to retrieve."
          }
        ],
        responses: {
          200: {
            description: "Detailed information about the recitation.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/RecitationFullRes"
                }
              }
            }
          },
          400: {
            description: "Bad request, invalid recitationId provided.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          404: {
            description: "Recitation not found for the given ID.",
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
      }
    },
    "/recitation-files-path": {
      get: {
        summary: "Get Recitation Files Path",
        description: "Retrieve the paths for audio and image files used in recitations.",
        tags: ["Recitation"],
        responses: {
          200: {
            description: "Paths for audio and image files.",
            content: {
              "application/json": {
                schema: {
                  type: "object",
                  properties: {
                    audiosPath: {
                      type: "string",
                      description: "Path for audio files."
                    },
                    imagesPath: {
                      type: "string",
                      description: "Path for image files."
                    }
                  }
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
      }
    },
  },
  components: {
    schemas: {
      RecitationFullRes: {
        "type": "object",
        "properties": {
          "id": {
            "type": "integer",
            "description": "ID of the recitation."
          },
          "audio": {
            "type": "string",
            "format": "uri",
            "description": "URL of the audio file for the recitation."
          },
          "image": {
            "type": "string",
            "format": "uri",
            "description": "URL of the image file for the recitation."
          },
          "title": {
            "type": "object",
            "properties": {
              "en": {
                "type": "string",
                "description": "English title."
              },
              "ar": {
                "type": "string",
                "description": "Arabic title."
              }
            },
            "description": "Localized title of the recitation."
          },
          "sequence": {
            "type": "integer",
            "description": "Sequence number of the recitation."
          },
          "reciter": {
            "type": "object",
            "properties": {
              "name": {
                "type": "string",
                "description": "Name of the reciter."
              },
              "id": {
                "type": "integer",
                "nullable": true,
                "description": "ID of the reciter."
              },
              "image": {
                "type": "string",
                "nullable": true,
                "format": "uri",
                "description": "URL of the reciter's image."
              }
            },
            "description": "Details of the reciter for the recitation."
          },
          "khatmaId": {
            "type": "integer",
            "description": "ID of the khatma associated with the recitation."
          }
        }
      }

    },
  },
};
