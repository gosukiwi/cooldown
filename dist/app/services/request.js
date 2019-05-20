var superagent;

superagent = require('superagent');

exports.Request = class {
  post(url, credentials, params, callback) {
    return superagent.post(url).set("User-Agent", "request").auth(credentials.username, credentials.password).send(params).end(callback); // callback is called with (err, res)
  }

};
