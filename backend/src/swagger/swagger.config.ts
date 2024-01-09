import * as swaggerJSDoc from "swagger-jsdoc";
import * as fs from "fs";
import * as path from "path";


const combineSwaggerDocs = (): swaggerJSDoc.SwaggerDefinition => {
  const basePath = path.join(__dirname, './');
  console.log(`Swagger ${basePath}`);
  const files = fs.readdirSync(basePath).filter(file => file.search('.json') != -1);


  // KhatmaController
  const combined: swaggerJSDoc.SwaggerDefinition = {
    // Like the one described here: https://swagger.io/specification/#infoObject
    basePath: '/',
    openapi: '3.0.0',
    info: {
      title: 'Express API for Kawtharuna',
      version: '1.0.0',
      description: 'This is a REST API application made with Express.',
    },
    servers: [

      {
        url: 'https://www.api.kawtharuna.com/v1',
        description: 'Production server.',
      },
      {
        url: 'http://localhost:8080/v1',
        description: 'Development server, when you run the application directly from the command line on your local machine.',
      }

    ],
    components: {
      "schemas": {
        KhatmaResumedRes: {
          "type": "object",
          "properties": {
            "id": {
              "type": "integer",
              "nullable": true,
              "description": "ID of the Khatma."
            },
            "name": {
              "$ref": "#/components/schemas/LocalizedEntity"
            },
            "reciter": {
              "type": "object",
              "properties": {
                "name": {
                  "$ref": "#/components/schemas/LocalizedEntity"
                },
                "id": {
                  "type": "integer",
                  "nullable": true
                },
                "image": {
                  "type": "string",
                  "nullable": true,
                  "format": "uri",
                  "description": "URL of the reciter's image."
                }
              }
            }
          }
        },
        KhatmaFullRes: {
          "allOf": [
            {
              "$ref": "#/components/schemas/KhatmaResumedRes"
            },
            {
              "type": "object",
              "properties": {
                "totalDownloads": {
                  "type": "integer",
                  "nullable": true,
                  "description": "Total number of downloads for the Khatma."
                },
                "totalPlays": {
                  "type": "integer",
                  "nullable": true,
                  "description": "Total number of plays for the Khatma."
                }
              }
            }
          ]
        },
        LocalizedEntity: {
          "type": "object",
          "properties": {
            "en": {
              "type": "string",
              "description": "English version of the localized field."
            },
            "ar": {
              "type": "string",
              "description": "Arabic version of the localized field."
            }
          }
        },
        LanguageResumedRes: {
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
        LanguageResumedItem: {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "Name of created language."
            },
            "id": {
              "type": "number",
              "description": "Id of the created language."
            }
          }
        },

        DeleteResponse: {
          type: "boolean",
          example: true
        },
        ErrorResponse: {
          "type": "object",
          "properties": {
            "error": {
              "type": "object",
              "properties": {
                status:
                {
                  type: "integer"
                },
                code:
                {
                  type: "string"
                },
                description:
                {
                  type: "string"
                }
              },
            },

          }
        },
      }
    },
  };

  files.forEach((file) => {
    const doc = JSON.parse(fs.readFileSync(path.join(basePath, file), 'utf8'));
    combined.paths = { ...combined.paths, ...doc.paths };
    combined.definitions = { ...combined.definitions, ...doc.definitions };
  });

  return combined;
};

const swaggerDefinition = combineSwaggerDocs();

export const options: swaggerJSDoc.Options = {
  swaggerDefinition,
  failOnErrors: true,
  apis: [
    "src/controllers/**-controller/*.ts",
    "src/controllers/**-controller/responses/*.ts"
  ]
};

// npm install swagger-ui-express swagger-jsdoc --save
