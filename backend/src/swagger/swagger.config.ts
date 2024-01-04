// import { KhatmaController } from "../controllers/khatma-controller/khatma-controller.ts";

import swaggerJSDoc = require("swagger-jsdoc");


// KhatmaController
const swaggerDefinition:swaggerJSDoc.SwaggerDefinition = {
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
            url: 'http://localhost:8080',
            description: 'Development server, when you run the application directly from the command line on your local machine.',
        }

    ],
    components: {
        "schemas": {
          "KhatmaResumedRes": {
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
          "KhatmaFullRes": {
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
          "LocalizedEntity": {
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
          }
        }
      },
};


export const options: swaggerJSDoc.Options = {
    swaggerDefinition,
    failOnErrors: true,
    apis: [
        "src/controllers/khatma-controller/*.ts",
        "src/controllers/khatma-controller/responses/*.ts"
    ]
};

// npm install swagger-ui-express swagger-jsdoc --save
