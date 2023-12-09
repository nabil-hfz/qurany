module.exports = {
    // Automatically clear mock calls and instances between every test
    clearMocks: true,
  
    // The glob patterns Jest uses to detect test files
    testMatch: [
      "**/__tests__/**/*.[jt]s?(x)",
      "**/?(*.)+(spec|test).[tj]s?(x)"
    ],
  
    // The test environment that will be used for testing
    testEnvironment: "node",
  
    // A map from regular expressions to paths to transformers
    transform: {
      "^.+\\.tsx?$": "ts-jest",
    },
  };
  