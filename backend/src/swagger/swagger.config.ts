import { healthControllerSwagger } from './health-controller.swagger';
import * as swaggerJSDoc from "swagger-jsdoc";
import { khatmaControllerSwagger } from './khatma-controller.swagger';
import { libraryControllerSwagger } from './library-controller.swagger';
import { languageControllerSwagger } from './library-language-controller.swagger';
import { recitationControllerSwagger } from './recitation-controller.swagger';
import { reciterControllerSwagger } from './reciter-controller.swagger';
import { libraryCategoryControllerSwagger } from './library-category-controller.swagger';
import { accountServiceControllerSwagger } from './account-controller.swagger';


const combineSwaggerDocs = (): swaggerJSDoc.SwaggerDefinition => {


  const combined: swaggerJSDoc.SwaggerDefinition = {
    basePath: '/',
    openapi: '3.0.0',
    info: {
      title: 'Express API for Kawtharuna',
      version: '1.0.0',
      description: 'This is a REST API application made with Express.',
    },
    servers: [
      {
        url: 'http://localhost:8080/v1',
        description: 'Development server, when you run the application directly from the command line on your local machine.',
      },
      {
        url: 'https://api.dev.kawtharuna.com/v1',
        description: 'Development server, when you run the application directly from the command line on your local machine.',
      },
      {
        url: 'https://api.kawtharuna.com/v1',
        description: 'Production server.',
      },

    ],
    components: {
      parameters: {
        "PageParam": {
          "in": "query",
          "name": "page",
          "required": false,
          "schema": {
            "type": "integer",
            "default": 1
          },
          "description": "Page number of the results to fetch."
        },
        "LimitParam": {
          "in": "query",
          "name": "limit",
          "required": false,
          "schema": {
            "type": "integer",
            "default": 30
          },
          "description": "Number of results per page."
        }
      },
      schemas: {
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
        "ResponseListModel": {
          "type": "object",
          "properties": {
            "items": {
              "type": "array",
              "items": {
                "type": "object",
                "description": "Array of items. The structure of these items will depend on the specific use case."
              }
            },
            "message": {
              "type": "string",
              "nullable": true,
              "description": "Optional message accompanying the response."
            }
          },
          "required": ["items"],
          "description": "A model representing a list response, typically used for paginated data."
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
        ...healthControllerSwagger.components.schemas,
        ...khatmaControllerSwagger.components.schemas,
        ...recitationControllerSwagger.components.schemas,
        ...reciterControllerSwagger.components.schemas,
        ...libraryControllerSwagger.components.schemas,
        ...languageControllerSwagger.components.schemas,
        ...libraryCategoryControllerSwagger.components.schemas,
        ...accountServiceControllerSwagger.components.schemas,

      }
    },
    paths: {
      ...healthControllerSwagger.paths,
      ...khatmaControllerSwagger.paths,
      ...recitationControllerSwagger.paths,
      ...reciterControllerSwagger.paths,
      ...libraryControllerSwagger.paths,
      ...languageControllerSwagger.paths,
      ...libraryCategoryControllerSwagger.paths,
      ...accountServiceControllerSwagger.paths,
    },
  };
  return combined;
};

const swaggerDefinition = combineSwaggerDocs();

export const options: swaggerJSDoc.Options = {
  swaggerDefinition,
  failOnErrors: true,
  apis: [
    // "src/controllers/**-controller/*.ts",
    // "src/controllers/**-controller/responses/*.ts"
  ]
};