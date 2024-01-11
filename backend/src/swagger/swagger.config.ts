import * as swaggerJSDoc from "swagger-jsdoc";
import { khatmaControllerSwagger } from './khatmaController.swagger';
import { libraryControllerSwagger } from './libraryController.swagger';
import { languageControllerSwagger } from './languageController.swagger';


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
        url: 'https://www.api.kawtharuna.com/v1',
        description: 'Production server.',
      },
      {
        url: 'http://localhost:8080/v1',
        description: 'Development server, when you run the application directly from the command line on your local machine.',
      }

    ],
    components: {

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
        ...khatmaControllerSwagger.components,
        ...libraryControllerSwagger.components,
        ...languageControllerSwagger.components,

      }
    },
    paths: {
      ...khatmaControllerSwagger.paths,
      ...libraryControllerSwagger.paths,
      ...languageControllerSwagger.paths,
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