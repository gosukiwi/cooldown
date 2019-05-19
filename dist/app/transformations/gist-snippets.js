var GistStore, codes, sha1, store;

({GistStore} = require("../gist-store"));

sha1 = require('sha1');

store = new GistStore("gosukiwi");

codes = {
  actionscript3: 'as',
  asp: 'asp',
  c: 'c',
  clojure: 'clj',
  coffeescript: 'coffee',
  csharp: 'cs',
  bash: 'sh',
  javascript: 'js',
  markdown: 'md',
  python: 'py',
  ruby: 'rb'
};

exports.GistSnippets = {
  code_block: {
    enter: function(node) {
      var extension, info_words, language, options;
      info_words = node.info ? node.info.split(/\s+/) : [];
      language = info_words[0];
      extension = (codes != null ? codes[language] : void 0) || language;
      sha1 = sha1(node.literal);
      options = {
        description: "Demo from node",
        public: false,
        files: {
          [`snippet-${sha1}.${extension}`]: {
            content: node.literal
          }
        }
      };
      return store.create(options, function(err, res) {
        return console.log("GIST:", res);
      });
    }
  }
};
