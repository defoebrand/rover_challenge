const config = {
  "roots": [
    "app/javascript"
  ],
  "testEnvironment": "jsdom",
  "verbose": true,
  "testURL": "http://localhost",
  "moduleDirectories": [
    "node_modules",
    "app/javascript"
  ],
  "transformIgnorePatterns": [
    "node_modules/(?!@ngrx|(?!deck.gl)|ng-dynamic)"
  ],
  "testPathIgnorePatterns": [
    "/node_modules/",
    "/config/"
  ],
  "testMatch": [
    '<rootDir>/app/javascript/tests/*.js'
  ],
};

module.exports = config;