{"semanticHighlighting" = true;
  "semanticTokenColors" = {
    "enumMember" = {
      "foreground" = "#94e2d5";
    };
    "selfKeyword" = {
      "foreground" = "#f38ba8";
    };
    "boolean" = {
      "foreground" = "#fab387";
    };
    "number" = {
      "foreground" = "#fab387";
    };
    "variable.defaultLibrary" = {
      "foreground" = "#eba0ac";
    };
    "class:python" = {
      "foreground" = "#f9e2af";
    };
    "class.builtin:python" = {
      "foreground" = "#cba6f7";
    };
    "variable.typeHint:python" = {
      "foreground" = "#f9e2af";
    };
    "function.decorator:python" = {
      "foreground" = "#fab387";
    };
    "variable.readonly:javascript" = {
      "foreground" = "#cdd6f4";
    };
    "variable.readonly:typescript" = {
      "foreground" = "#cdd6f4";
    };
    "property.readonly:javascript" = {
      "foreground" = "#cdd6f4";
    };
    "property.readonly:typescript" = {
      "foreground" = "#cdd6f4";
    };
    "variable.readonly:javascriptreact" = {
      "foreground" = "#cdd6f4";
    };
    "variable.readonly:typescriptreact" = {
      "foreground" = "#cdd6f4";
    };
    "property.readonly:javascriptreact" = {
      "foreground" = "#cdd6f4";
    };
    "property.readonly:typescriptreact" = {
      "foreground" = "#cdd6f4";
    };
    "variable.readonly:scala" = {
      "foreground" = "#cdd6f4";
    };
    "type.defaultLibrary:go" = {
      "foreground" = "#cba6f7";
    };
    "variable.readonly.defaultLibrary:go" = {
      "foreground" = "#cba6f7";
    };
    "tomlArrayKey" = {
      "foreground" = "#89b4fa";
      "fontStyle" = "";
    };
    "tomlTableKey" = {
      "foreground" = "#89b4fa";
      "fontStyle" = "";
    };
    "builtinAttribute.attribute.library:rust" = {
      "foreground" = "#89b4fa";
    };
    "generic.attribute:rust" = {
      "foreground" = "#cdd6f4";
    };
    "constant.builtin.readonly:nix" = {
      "foreground" = "#cba6f7";
    };
    "heading" = {
      "foreground" = "#f38ba8";
    };
    "text.emph" = {
      "foreground" = "#f38ba8";
      "fontStyle" = "italic";
    };
    "text.strong" = {
      "foreground" = "#f38ba8";
      "fontStyle" = "bold";
    };
    "text.math" = {
      "foreground" = "#f2cdcd";
    };
    "pol" = {
      "foreground" = "#f2cdcd";
    };
  };
  "tokenColors" = [
    {
      "name" = "Basic text & variable names (incl. leading punctuation)";
      "scope" = [
        "text"
        "source"
        "variable.other.readwrite"
        "punctuation.definition.variable"
      ];
      "settings" = {
        "foreground" = "#cdd6f4";
      };
    }
    {
      "name" = "Parentheses, Brackets, Braces";
      "scope" = "punctuation";
      "settings" = {
        "foreground" = "#9399b2";
        "fontStyle" = "";
      };
    }
    {
      "name" = "Comments";
      "scope" = [
        "comment"
        "punctuation.definition.comment"
      ];
      "settings" = {
        "foreground" = "#6c7086";
        "fontStyle" = "italic";
      };
    }
    {
      "scope" = [
        "string"
        "punctuation.definition.string"
      ];
      "settings" = {
        "foreground" = "#a6e3a1";
      };
    }
    {
      "scope" = "constant.character.escape";
      "settings" = {
        "foreground" = "#f5c2e7";
      };
    }
    {
      "name" = "Booleans, constants, numbers";
      "scope" = [
        "constant.numeric"
        "variable.other.constant"
        "entity.name.constant"
        "constant.language.boolean"
        "constant.language.false"
        "constant.language.true"
        "keyword.other.unit.user-defined"
        "keyword.other.unit.suffix.floating-point"
      ];
      "settings" = {
        "foreground" = "#fab387";
      };
    }
    {
      "scope" = [
        "keyword"
        "keyword.operator.word"
        "keyword.operator.new"
        "variable.language.super"
        "support.type.primitive"
        "storage.type"
        "storage.modifier"
        "punctuation.definition.keyword"
      ];
      "settings" = {
        "foreground" = "#cba6f7";
        "fontStyle" = "";
      };
    }
    {
      "scope" = "entity.name.tag.documentation";
      "settings" = {
        "foreground" = "#cba6f7";
      };
    }
    {
      "name" = "Punctuation";
      "scope" = [
        "keyword.operator"
        "punctuation.accessor"
        "punctuation.definition.generic"
        "meta.function.closure punctuation.section.parameters"
        "punctuation.definition.tag"
        "punctuation.separator.key-value"
      ];
      "settings" = {
        "foreground" = "#94e2d5";
      };
    }
    {
      "scope" = [
        "entity.name.function"
        "meta.function-call.method"
        "support.function"
        "support.function.misc"
        "variable.function"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
        "fontStyle" = "italic";
      };
    }
    {
      "name" = "Classes";
      "scope" = [
        "entity.name.class"
        "entity.other.inherited-class"
        "support.class"
        "meta.function-call.constructor"
        "entity.name.struct"
      ];
      "settings" = {
        "foreground" = "#f9e2af";
        "fontStyle" = "italic";
      };
    }
    {
      "name" = "Enum";
      "scope" = "entity.name.enum";
      "settings" = {
        "foreground" = "#f9e2af";
        "fontStyle" = "italic";
      };
    }
    {
      "name" = "Enum member";
      "scope" = [
        "meta.enum variable.other.readwrite"
        "variable.other.enummember"
      ];
      "settings" = {
        "foreground" = "#94e2d5";
      };
    }
    {
      "name" = "Object properties";
      "scope" = "meta.property.object";
      "settings" = {
        "foreground" = "#94e2d5";
      };
    }
    {
      "name" = "Types";
      "scope" = [
        "meta.type"
        "meta.type-alias"
        "support.type"
        "entity.name.type"
      ];
      "settings" = {
        "foreground" = "#f9e2af";
        "fontStyle" = "italic";
      };
    }
    {
      "name" = "Decorators";
      "scope" = [
        "meta.annotation variable.function"
        "meta.annotation variable.annotation.function"
        "meta.annotation punctuation.definition.annotation"
        "meta.decorator"
        "punctuation.decorator"
      ];
      "settings" = {
        "foreground" = "#fab387";
      };
    }
    {
      "scope" = [
        "variable.parameter"
        "meta.function.parameters"
      ];
      "settings" = {
        "foreground" = "#eba0ac";
        "fontStyle" = "italic";
      };
    }
    {
      "name" = "Built-ins";
      "scope" = [
        "constant.language"
        "support.function.builtin"
      ];
      "settings" = {
        "foreground" = "#f38ba8";
      };
    }
    {
      "scope" = "entity.other.attribute-name.documentation";
      "settings" = {
        "foreground" = "#f38ba8";
      };
    }
    {
      "name" = "Preprocessor directives";
      "scope" = [
        "keyword.control.directive"
        "punctuation.definition.directive"
      ];
      "settings" = {
        "foreground" = "#f9e2af";
      };
    }
    {
      "name" = "Type parameters";
      "scope" = "punctuation.definition.typeparameters";
      "settings" = {
        "foreground" = "#89dceb";
      };
    }
    {
      "name" = "Namespaces";
      "scope" = "entity.name.namespace";
      "settings" = {
        "foreground" = "#f9e2af";
      };
    }
    {
      "name" = "Property names (left hand assignments in json/yaml/css)";
      "scope" = "support.type.property-name.css";
      "settings" = {
        "foreground" = "#89b4fa";
        "fontStyle" = "";
      };
    }
    {
      "name" = "This/Self keyword";
      "scope" = [
        "variable.language.this"
        "variable.language.this punctuation.definition.variable"
      ];
      "settings" = {
        "foreground" = "#f38ba8";
      };
    }
    {
      "name" = "Object properties";
      "scope" = "variable.object.property";
      "settings" = {
        "foreground" = "#cdd6f4";
      };
    }
    {
      "name" = "String template interpolation";
      "scope" = [
        "string.template variable"
        "string variable"
      ];
      "settings" = {
        "foreground" = "#cdd6f4";
      };
    }
    {
      "name" = "`new` as bold";
      "scope" = "keyword.operator.new";
      "settings" = {
        "fontStyle" = "bold";
      };
    }
    {
      "name" = "C++ extern keyword";
      "scope" = "storage.modifier.specifier.extern.cpp";
      "settings" = {
        "foreground" = "#cba6f7";
      };
    }
    {
      "name" = "C++ scope resolution";
      "scope" = [
        "entity.name.scope-resolution.template.call.cpp"
        "entity.name.scope-resolution.parameter.cpp"
        "entity.name.scope-resolution.cpp"
        "entity.name.scope-resolution.function.definition.cpp"
      ];
      "settings" = {
        "foreground" = "#f9e2af";
      };
    }
    {
      "name" = "C++ doc keywords";
      "scope" = "storage.type.class.doxygen";
      "settings" = {
        "fontStyle" = "";
      };
    }
    {
      "name" = "C++ operators";
      "scope" = [
        "storage.modifier.reference.cpp"
      ];
      "settings" = {
        "foreground" = "#94e2d5";
      };
    }
    {
      "name" = "C# Interpolated Strings";
      "scope" = "meta.interpolation.cs";
      "settings" = {
        "foreground" = "#cdd6f4";
      };
    }
    {
      "name" = "C# xml-style docs";
      "scope" = "comment.block.documentation.cs";
      "settings" = {
        "foreground" = "#cdd6f4";
      };
    }
    {
      "name" = "Classes, reflecting the className color in JSX";
      "scope" = [
        "source.css entity.other.attribute-name.class.css"
        "entity.other.attribute-name.parent-selector.css punctuation.definition.entity.css"
      ];
      "settings" = {
        "foreground" = "#f9e2af";
      };
    }
    {
      "name" = "Operators";
      "scope" = "punctuation.separator.operator.css";
      "settings" = {
        "foreground" = "#94e2d5";
      };
    }
    {
      "name" = "Pseudo classes";
      "scope" = "source.css entity.other.attribute-name.pseudo-class";
      "settings" = {
        "foreground" = "#94e2d5";
      };
    }
    {
      "scope" = "source.css constant.other.unicode-range";
      "settings" = {
        "foreground" = "#fab387";
      };
    }
    {
      "scope" = "source.css variable.parameter.url";
      "settings" = {
        "foreground" = "#a6e3a1";
        "fontStyle" = "";
      };
    }
    {
      "name" = "CSS vendored property names";
      "scope" = [
        "support.type.vendored.property-name"
      ];
      "settings" = {
        "foreground" = "#89dceb";
      };
    }
    {
      "name" = "Less/SCSS right-hand variables (@/$-prefixed)";
      "scope" = [
        "source.css meta.property-value variable"
        "source.css meta.property-value variable.other.less"
        "source.css meta.property-value variable.other.less punctuation.definition.variable.less"
        "meta.definition.variable.scss"
      ];
      "settings" = {
        "foreground" = "#eba0ac";
      };
    }
    {
      "name" = "CSS variables (--prefixed)";
      "scope" = [
        "source.css meta.property-list variable"
        "meta.property-list variable.other.less"
        "meta.property-list variable.other.less punctuation.definition.variable.less"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
      };
    }
    {
      "name" = "CSS Percentage values, styled the same as numbers";
      "scope" = "keyword.other.unit.percentage.css";
      "settings" = {
        "foreground" = "#fab387";
      };
    }
    {
      "name" = "CSS Attribute selectors, styled the same as strings";
      "scope" = "source.css meta.attribute-selector";
      "settings" = {
        "foreground" = "#a6e3a1";
      };
    }
    {
      "name" = "JSON/YAML keys, other left-hand assignments";
      "scope" = [
        "keyword.other.definition.ini"
        "punctuation.support.type.property-name.json"
        "support.type.property-name.json"
        "punctuation.support.type.property-name.toml"
        "support.type.property-name.toml"
        "entity.name.tag.yaml"
        "punctuation.support.type.property-name.yaml"
        "support.type.property-name.yaml"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
        "fontStyle" = "";
      };
    }
    {
      "name" = "JSON/YAML constants";
      "scope" = [
        "constant.language.json"
        "constant.language.yaml"
      ];
      "settings" = {
        "foreground" = "#fab387";
      };
    }
    {
      "name" = "YAML anchors";
      "scope" = [
        "entity.name.type.anchor.yaml"
        "variable.other.alias.yaml"
      ];
      "settings" = {
        "foreground" = "#f9e2af";
        "fontStyle" = "";
      };
    }
    {
      "name" = "TOML tables / ini groups";
      "scope" = [
        "support.type.property-name.table"
        "entity.name.section.group-title.ini"
      ];
      "settings" = {
        "foreground" = "#f9e2af";
      };
    }
    {
      "name" = "TOML dates";
      "scope" = "constant.other.time.datetime.offset.toml";
      "settings" = {
        "foreground" = "#f5c2e7";
      };
    }
    {
      "name" = "YAML anchor puctuation";
      "scope" = [
        "punctuation.definition.anchor.yaml"
        "punctuation.definition.alias.yaml"
      ];
      "settings" = {
        "foreground" = "#f5c2e7";
      };
    }
    {
      "name" = "YAML triple dashes";
      "scope" = "entity.other.document.begin.yaml";
      "settings" = {
        "foreground" = "#f5c2e7";
      };
    }
    {
      "name" = "Markup Diff";
      "scope" = "markup.changed.diff";
      "settings" = {
        "foreground" = "#fab387";
      };
    }
    {
      "name" = "Diff";
      "scope" = [
        "meta.diff.header.from-file"
        "meta.diff.header.to-file"
        "punctuation.definition.from-file.diff"
        "punctuation.definition.to-file.diff"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
      };
    }
    {
      "name" = "Diff Inserted";
      "scope" = "markup.inserted.diff";
      "settings" = {
        "foreground" = "#a6e3a1";
      };
    }
    {
      "name" = "Diff Deleted";
      "scope" = "markup.deleted.diff";
      "settings" = {
        "foreground" = "#f38ba8";
      };
    }
    {
      "name" = "dotenv left-hand side assignments";
      "scope" = [
        "variable.other.env"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
      };
    }
    {
      "name" = "dotenv reference to existing env variable";
      "scope" = [
        "string.quoted variable.other.env"
      ];
      "settings" = {
        "foreground" = "#cdd6f4";
      };
    }
    {
      "name" = "GDScript functions";
      "scope" = "support.function.builtin.gdscript";
      "settings" = {
        "foreground" = "#89b4fa";
      };
    }
    {
      "name" = "GDScript constants";
      "scope" = "constant.language.gdscript";
      "settings" = {
        "foreground" = "#fab387";
      };
    }
    {
      "name" = "Comment keywords";
      "scope" = "comment meta.annotation.go";
      "settings" = {
        "foreground" = "#eba0ac";
      };
    }
    {
      "name" = "go:embed, go:build, etc.";
      "scope" = "comment meta.annotation.parameters.go";
      "settings" = {
        "foreground" = "#fab387";
      };
    }
    {
      "name" = "Go constants (nil, true, false)";
      "scope" = "constant.language.go";
      "settings" = {
        "foreground" = "#fab387";
      };
    }
    {
      "name" = "GraphQL variables";
      "scope" = "variable.graphql";
      "settings" = {
        "foreground" = "#cdd6f4";
      };
    }
    {
      "name" = "GraphQL aliases";
      "scope" = "string.unquoted.alias.graphql";
      "settings" = {
        "foreground" = "#f2cdcd";
      };
    }
    {
      "name" = "GraphQL enum members";
      "scope" = "constant.character.enum.graphql";
      "settings" = {
        "foreground" = "#94e2d5";
      };
    }
    {
      "name" = "GraphQL field in types";
      "scope" = "meta.objectvalues.graphql constant.object.key.graphql string.unquoted.graphql";
      "settings" = {
        "foreground" = "#f2cdcd";
      };
    }
    {
      "name" = "HTML/XML DOCTYPE as keyword";
      "scope" = [
        "keyword.other.doctype"
        "meta.tag.sgml.doctype punctuation.definition.tag"
        "meta.tag.metadata.doctype entity.name.tag"
        "meta.tag.metadata.doctype punctuation.definition.tag"
      ];
      "settings" = {
        "foreground" = "#cba6f7";
      };
    }
    {
      "name" = "HTML/XML-like <tags/>";
      "scope" = [
        "entity.name.tag"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
        "fontStyle" = "";
      };
    }
    {
      "name" = "Special characters like &amp;";
      "scope" = [
        "text.html constant.character.entity"
        "text.html constant.character.entity punctuation"
        "constant.character.entity.xml"
        "constant.character.entity.xml punctuation"
        "constant.character.entity.js.jsx"
        "constant.charactger.entity.js.jsx punctuation"
        "constant.character.entity.tsx"
        "constant.character.entity.tsx punctuation"
      ];
      "settings" = {
        "foreground" = "#f38ba8";
      };
    }
    {
      "name" = "HTML/XML tag attribute values";
      "scope" = [
        "entity.other.attribute-name"
      ];
      "settings" = {
        "foreground" = "#f9e2af";
      };
    }
    {
      "name" = "Components";
      "scope" = [
        "support.class.component"
        "support.class.component.jsx"
        "support.class.component.tsx"
        "support.class.component.vue"
      ];
      "settings" = {
        "foreground" = "#f5c2e7";
        "fontStyle" = "";
      };
    }
    {
      "name" = "Annotations";
      "scope" = [
        "punctuation.definition.annotation"
        "storage.type.annotation"
      ];
      "settings" = {
        "foreground" = "#fab387";
      };
    }
    {
      "name" = "Java enums";
      "scope" = "constant.other.enum.java";
      "settings" = {
        "foreground" = "#94e2d5";
      };
    }
    {
      "name" = "Java imports";
      "scope" = "storage.modifier.import.java";
      "settings" = {
        "foreground" = "#cdd6f4";
      };
    }
    {
      "name" = "Javadoc";
      "scope" = "comment.block.javadoc.java keyword.other.documentation.javadoc.java";
      "settings" = {
        "fontStyle" = "";
};
}
    {
      "name" = "Exported Variable";
      "scope" = "meta.export variable.other.readwrite.js";
      "settings" = {
        "foreground" = "#eba0ac";
      };
    }
    {
      "name" = "JS/TS constants & properties";
      "scope" = [
        "variable.other.constant.js"
        "variable.other.constant.ts"
        "variable.other.property.js"
        "variable.other.property.ts"
      ];
      "settings" = {
        "foreground" = "#cdd6f4";
      };
    }
    {
      "name" = "JSDoc; these are mainly params, so styled as such";
      "scope" = [
        "variable.other.jsdoc"
        "comment.block.documentation variable.other"
      ];
      "settings" = {
        "foreground" = "#eba0ac";
        "fontStyle" = "";
      };
    }
    {
      "name" = "JSDoc keywords";
      "scope" = "storage.type.class.jsdoc";
      "settings" = {
        "fontStyle" = "";
      };
    }
    {
      "scope" = "support.type.object.console.js";
      "settings" = {
        "foreground" = "#cdd6f4"
};
}
    {
      "name" = "Node constants as keywords (module, etc.)";
      "scope" = [
        "support.constant.node"
        "support.type.object.module.js"
      ];
      "settings" = {
        "foreground" = "#cba6f7";
};
}
    {
      "name" = "implements as keyword";
      "scope" = "storage.modifier.implements";
      "settings" = {
        "foreground" = "#cba6f7";
};
}
    {
      "name" = "Builtin types";
      "scope" = [
        "constant.language.null.js"
        "constant.language.null.ts"
        "constant.language.undefined.js"
        "constant.language.undefined.ts"
        "support.type.builtin.ts"
      ];
      "settings" = {
        "foreground" = "#cba6f7";
};
}
    {
      "scope" = "variable.parameter.generic";
      "settings" = {
        "foreground" = "#f9e2af";
};
}
    {
      "name" = "Arrow functions";
      "scope" = [
        "keyword.declaration.function.arrow.js"
        "storage.type.function.arrow.ts"
      ];
      "settings" = {
        "foreground" = "#94e2d5";
};
}
    {
      "name" = "Decorator punctuations (decorators inherit from blue functions, instead of styleguide peach)";
      "scope" = "punctuation.decorator.ts";
      "settings" = {
        "foreground" = "#89b4fa";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Extra JS/TS keywords";
      "scope" = [
        "keyword.operator.expression.in.js"
        "keyword.operator.expression.in.ts"
        "keyword.operator.expression.infer.ts"
        "keyword.operator.expression.instanceof.js"
        "keyword.operator.expression.instanceof.ts"
        "keyword.operator.expression.is"
        "keyword.operator.expression.keyof.ts"
        "keyword.operator.expression.of.js"
        "keyword.operator.expression.of.ts"
        "keyword.operator.expression.typeof.ts"
      ];
      "settings" = {
        "foreground" = "#cba6f7";
};
}
    {
      "name" = "Julia macros";
      "scope" = "support.function.macro.julia";
      "settings" = {
        "foreground" = "#94e2d5";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Julia language constants (true, false)";
      "scope" = "constant.language.julia";
      "settings" = {
        "foreground" = "#fab387";
};
}
    {
      "name" = "Julia other constants (these seem to be arguments inside arrays)";
      "scope" = "constant.other.symbol.julia";
      "settings" = {
        "foreground" = "#eba0ac";
};
}
    {
      "name" = "LaTeX preamble";
      "scope" = "text.tex keyword.control.preamble";
      "settings" = {
        "foreground" = "#94e2d5";
};
}
    {
      "name" = "LaTeX be functions";
      "scope" = "text.tex support.function.be";
      "settings" = {
        "foreground" = "#89dceb";
};
}
    {
      "name" = "LaTeX math";
      "scope" = "constant.other.general.math.tex";
      "settings" = {
        "foreground" = "#f2cdcd";
};
}
    {
      "name" = "Lua docstring keywords";
      "scope" = "comment.line.double-dash.documentation.lua storage.type.annotation.lua";
      "settings" = {
        "foreground" = "#cba6f7";
        "fontStyle" = "";
};
}
    {
      "name" = "Lua docstring variables";
      "scope" = [
        "comment.line.double-dash.documentation.lua entity.name.variable.lua";
        "comment.line.double-dash.documentation.lua variable.lua"
      ];
      "settings" = {
        "foreground" = "#cdd6f4";
};
}
    {
      "scope" = [
        "heading.1.markdown punctuation.definition.heading.markdown"
        "heading.1.markdown"
        "heading.1.quarto punctuation.definition.heading.quarto"
        "heading.1.quarto"
        "markup.heading.atx.1.mdx"
        "markup.heading.atx.1.mdx punctuation.definition.heading.mdx"
        "markup.heading.setext.1.markdown"
        "markup.heading.heading-0.asciidoc"
      ];
      "settings" = {
        "foreground" = "#f38ba8";
};
}
    {
      "scope" = [
        "heading.2.markdown punctuation.definition.heading.markdown"
        "heading.2.markdown"
        "heading.2.quarto punctuation.definition.heading.quarto"
        "heading.2.quarto"
        "markup.heading.atx.2.mdx"
        "markup.heading.atx.2.mdx punctuation.definition.heading.mdx"
        "markup.heading.setext.2.markdown"
        "markup.heading.heading-1.asciidoc"
      ];
      "settings" = {
        "foreground" = "#fab387";
};
}
    {
      "scope" = [
        "heading.3.markdown punctuation.definition.heading.markdown"
        "heading.3.markdown"
        "heading.3.quarto punctuation.definition.heading.quarto"
        "heading.3.quarto"
        "markup.heading.atx.3.mdx"
        "markup.heading.atx.3.mdx punctuation.definition.heading.mdx"
        "markup.heading.heading-2.asciidoc"
      ];
      "settings" = {
        "foreground" = "#f9e2af";
};
}
    {
      "scope" = [
        "heading.4.markdown punctuation.definition.heading.markdown"
        "heading.4.markdown"
        "heading.4.quarto punctuation.definition.heading.quarto"
        "heading.4.quarto"
        "markup.heading.atx.4.mdx"
        "markup.heading.atx.4.mdx punctuation.definition.heading.mdx"
        "markup.heading.heading-3.asciidoc"
      ];
      "settings" = {
        "foreground" = "#a6e3a1";
};
}
    {
      "scope" = [
        "heading.5.markdown punctuation.definition.heading.markdown"
        "heading.5.markdown"
        "heading.5.quarto punctuation.definition.heading.quarto"
        "heading.5.quarto"
        "markup.heading.atx.5.mdx"
        "markup.heading.atx.5.mdx punctuation.definition.heading.mdx"
        "markup.heading.heading-4.asciidoc"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
};
}
    {
      "scope" = [
        "heading.6.markdown punctuation.definition.heading.markdown"
        "heading.6.markdown"
        "heading.6.quarto punctuation.definition.heading.quarto"
        "heading.6.quarto"
        "markup.heading.atx.6.mdx"
        "markup.heading.atx.6.mdx punctuation.definition.heading.mdx"
        "markup.heading.heading-5.asciidoc"
      ];
      "settings" = {
        "foreground" = "#cba6f7";
};
}
    {
      "scope" = "markup.bold";
      "settings" = {
        "foreground" = "#f38ba8";
        "fontStyle" = "bold";
};
}
    {
      "scope" = "markup.italic";
      "settings" = {
        "foreground" = "#f38ba8";
        "fontStyle" = "italic";
};
}
    {
      "scope" = "markup.strikethrough";
      "settings" = {
        "foreground" = "#a6adc8";
        "fontStyle" = "strikethrough";
};
}
    {
      "name" = "Markdown auto links";
      "scope" = [
        "punctuation.definition.link";
        "markup.underline.link"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
};
}
    {
      "name" = "Markdown links";
      "scope" = [
        "text.html.markdown punctuation.definition.link.title"
        "text.html.quarto punctuation.definition.link.title"
        "string.other.link.title.markdown"
        "string.other.link.title.quarto"
        "markup.link"
        "punctuation.definition.constant.markdown"
        "punctuation.definition.constant.quarto"
        "constant.other.reference.link.markdown"
        "constant.other.reference.link.quarto"
        "markup.substitution.attribute-reference"
      ];
      "settings" = {
        "foreground" = "#b4befe";
};
}
    {
      "name" = "Markdown code spans";
      "scope" = [
        "punctuation.definition.raw.markdown"
        "punctuation.definition.raw.quarto"
        "markup.inline.raw.string.markdown"
        "markup.inline.raw.string.quarto"
        "markup.raw.block.markdown"
        "markup.raw.block.quarto"
      ];
      "settings" = {
        "foreground" = "#a6e3a1";
};
}
    {
      "name" = "Markdown triple backtick language identifier";
      "scope" = "fenced_code.block.language";
      "settings" = {
        "foreground" = "#89dceb";
};
}
    {
      "name" = "Markdown triple backticks";
      "scope" = [
        "markup.fenced_code.block punctuation.definition"
        "markup.raw support.asciidoc"
      ];
      "settings" = {
        "foreground" = "#9399b2";
};
}
    {
      "name" = "Markdown quotes";
      "scope" = [
        "markup.quote";
        "punctuation.definition.quote.begin"
      ];
      "settings" = {
        "foreground" = "#f5c2e7";
};
}
    {
      "name" = "Markdown separators";
      "scope" = "meta.separator.markdown";
      "settings" = {
        "foreground" = "#94e2d5";
};
}
    {
      "name" = "Markdown list bullets";
      "scope" = [
        "punctuation.definition.list.begin.markdown";
        "punctuation.definition.list.begin.quarto";
        "markup.list.bullet"
      ];
      "settings" = {
        "foreground" = "#94e2d5";
};
}
    {
      "name" = "Quarto headings";
      "scope" = "markup.heading.quarto";
      "settings" = {
        "fontStyle" = "bold";
};
}
    {
      "name" = "Nix attribute names";
      "scope" = [
        "entity.other.attribute-name.multipart.nix"
        "entity.other.attribute-name.single.nix"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
};
}
    {
      "name" = "Nix parameter names";
      "scope" = "variable.parameter.name.nix";
      "settings" = {
        "foreground" = "#cdd6f4";
        "fontStyle" = "";
};
}
    {
      "name" = "Nix interpolated parameter names";
      "scope" = "meta.embedded variable.parameter.name.nix";
      "settings" = {
        "foreground" = "#b4befe";
        "fontStyle" = "";
};
}
    {
      "name" = "Nix paths";
      "scope" = "string.unquoted.path.nix";
      "settings" = {
        "foreground" = "#f5c2e7";
        "fontStyle" = "";
};
}
    {
      "name" = "PHP Attributes";
      "scope" = [
        "support.attribute.builtin"
        "meta.attribute.php"
      ];
      "settings" = {
        "foreground" = "#f9e2af";
};
}
    {
      "name" = "PHP Parameters (needed for the leading dollar sign)";
      "scope" = "meta.function.parameters.php punctuation.definition.variable.php";
      "settings" = {
        "foreground" = "#eba0ac";
};
}
    {
      "name" = "PHP Constants (null, __FILE__, etc.)";
      "scope" = "constant.language.php";
      "settings" = {
        "foreground" = "#cba6f7";
};
}
    {
      "name" = "PHP functions";
      "scope" = "text.html.php support.function";
      "settings" = {
        "foreground" = "#89dceb";
};
}
    {
      "name" = "PHPdoc keywords";
      "scope" = "keyword.other.phpdoc.php";
      "settings" = {
        "fontStyle" = "";
};
}
    {
      "name" = "Python argument functions reset to text, otherwise they inherit blue from function-call";
      "scope" = [
        "support.variable.magic.python"
        "meta.function-call.arguments.python"
      ];
      "settings" = {
        "foreground" = "#cdd6f4";
};
}
    {
      "name" = "Python double underscore functions";
      "scope" = [
        "support.function.magic.python"
      ];
      "settings" = {
        "foreground" = "#89dceb";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Python `self` keyword";
      "scope" = [
        "variable.parameter.function.language.special.self.python"
        "variable.language.special.self.python"
      ];
      "settings" = {
        "foreground" = "#f38ba8";
        "fontStyle" = "italic";
};
}
    {
      "name" = "python keyword flow/logical (for ... in)";
      "scope" = [
        "keyword.control.flow.python"
        "keyword.operator.logical.python"
      ];
      "settings" = {
        "foreground" = "#cba6f7";
};
}
    {
      "name" = "python storage type";
      "scope" = "storage.type.function.python";
      "settings" = {
        "foreground" = "#cba6f7";
};
}
    {
      "name" = "python function support";
      "scope" = [
        "support.token.decorator.python"
        "meta.function.decorator.identifier.python"
      ];
      "settings" = {
        "foreground" = "#89dceb";
};
}
    {
      "name" = "python function calls";
      "scope" = [
        "meta.function-call.python"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
};
}
    {
      "name" = "python function decorators";
      "scope" = [
        "entity.name.function.decorator.python"
        "punctuation.definition.decorator.python"
      ];
      "settings" = {
        "foreground" = "#fab387";
        "fontStyle" = "italic";
};
}
    {
      "name" = "python placeholder reset to normal string";
      "scope" = "constant.character.format.placeholder.other.python";
      "settings" = {
        "foreground" = "#f5c2e7";
};
}
    {
      "name" = "Python exception & builtins such as exit()";
      "scope" = [
        "support.type.exception.python"
        "support.function.builtin.python"
      ];
      "settings" = {
        "foreground" = "#fab387";
};
}
    {
      "name" = "entity.name.type";
      "scope" = [
        "support.type.python"
      ];
      "settings" = {
        "foreground" = "#fab387";
};
}
    {
      "name" = "python constants (True/False)";
      "scope" = "constant.language.python";
      "settings" = {
        "foreground" = "#cba6f7";
};
}
    {
      "name" = "Arguments accessed later in the function body";
      "scope" = [
        "meta.indexed-name.python"
        "meta.item-access.python"
      ];
      "settings" = {
        "foreground" = "#eba0ac";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Python f-strings/binary/unicode storage types";
      "scope" = "storage.type.string.python";
      "settings" = {
        "foreground" = "#a6e3a1";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Python type hints";
      "scope" = "meta.function.parameters.python";
      "settings" = {
        "fontStyle" = "";
};
}
    {
      "name" = "Regex string begin/end in JS/TS";
      "scope" = [
        "string.regexp punctuation.definition.string.begin"
        "string.regexp punctuation.definition.string.end"
      ];
      "settings" = {
        "foreground" = "#f5c2e7";
};
}
    {
      "name" = "Regex anchors (^, $)";
      "scope" = "keyword.control.anchor.regexp";
      "settings" = {
        "foreground" = "#cba6f7";
};
}
    {
      "name" = "Regex regular string match";
      "scope" = "string.regexp.ts";
      "settings" = {
        "foreground" = "#cdd6f4";
};
}
    {
      "name" = "Regex group parenthesis & backreference (\\1, \\2, \\3, ...)";
      "scope" = [
        "punctuation.definition.group.regexp";
        "keyword.other.back-reference.regexp"
      ];
      "settings" = {
        "foreground" = "#a6e3a1";
};
}
    {
      "name" = "Regex character class []";
      "scope" = "punctuation.definition.character-class.regexp";
      "settings" = {
        "foreground" = "#f9e2af";
};
}
    {
      "name" = "Regex character classes (\\d, \\w, \\s)";
      "scope" = "constant.other.character-class.regexp";
      "settings" = {
        "foreground" = "#f5c2e7";
};
}
    {
      "name" = "Regex range";
      "scope" = "constant.other.character-class.range.regexp";
      "settings" = {
        "foreground" = "#f5e0dc";
};
}
    {
      "name" = "Regex quantifier";
      "scope" = "keyword.operator.quantifier.regexp";
      "settings" = {
        "foreground" = "#94e2d5";
};
}
    {
      "name" = "Regex constant/numeric";
      "scope" = "constant.character.numeric.regexp";
      "settings" = {
        "foreground" = "#fab387";
};
}
    {
      "name" = "Regex lookaheads, negative lookaheads, lookbehinds, negative lookbehinds";
      "scope" = [
        "punctuation.definition.group.no-capture.regexp"
        "meta.assertion.look-ahead.regexp"
        "meta.assertion.negative-look-ahead.regexp"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
};
}
    {
      "name" = "Rust attribute";
      "scope" = [
        "meta.annotation.rust";
        "meta.annotation.rust punctuation";
        "meta.attribute.rust";
        "punctuation.definition.attribute.rust"
      ];
      "settings" = {
        "foreground" = "#f9e2af";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Rust attribute strings";
      "scope" = [
        "meta.attribute.rust string.quoted.double.rust"
        "meta.attribute.rust string.quoted.single.char.rust"
      ];
      "settings" = {
        "fontStyle" = "";
};
}
    {
      "name" = "Rust keyword";
      "scope" = [
        "entity.name.function.macro.rules.rust"
        "storage.type.module.rust"
        "storage.modifier.rust"
        "storage.type.struct.rust"
        "storage.type.enum.rust"
        "storage.type.trait.rust"
        "storage.type.union.rust"
        "storage.type.impl.rust"
        "storage.type.rust"
        "storage.type.function.rust"
        "storage.type.type.rust"
      ];
      "settings" = {
        "foreground" = "#cba6f7";
        "fontStyle" = "";
};
}
    {
      "name" = "Rust u/i32, u/i64, etc.";
      "scope" = "entity.name.type.numeric.rust";
      "settings" = {
        "foreground" = "#cba6f7";
        "fontStyle" = "";
};
}
    {
      "name" = "Rust generic";
      "scope" = "meta.generic.rust";
      "settings" = {
        "foreground" = "#fab387";
};
}
    {
      "name" = "Rust impl";
      "scope" = "entity.name.impl.rust";
      "settings" = {
        "foreground" = "#f9e2af";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Rust module";
      "scope" = "entity.name.module.rust";
      "settings" = {
        "foreground" = "#fab387";
};
}
    {
      "name" = "Rust trait";
      "scope" = "entity.name.trait.rust";
      "settings" = {
        "foreground" = "#f9e2af";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Rust struct";
      "scope" = "storage.type.source.rust";
      "settings" = {
        "foreground" = "#f9e2af";
};
}
    {
      "name" = "Rust union";
      "scope" = "entity.name.union.rust";
      "settings" = {
        "foreground" = "#f9e2af";
};
}
    {
      "name" = "Rust enum member";
      "scope" = "meta.enum.rust storage.type.source.rust";
      "settings" = {
        "foreground" = "#94e2d5";
};
}
    {
      "name" = "Rust macro";
      "scope" = [
        "support.macro.rust"
        "meta.macro.rust support.function.rust"
        "entity.name.function.macro.rust"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Rust lifetime";
      "scope" = [
        "storage.modifier.lifetime.rust"
        "entity.name.type.lifetime"
      ];
      "settings" = {
        "foreground" = "#89b4fa";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Rust string formatting";
      "scope" = "string.quoted.double.rust constant.other.placeholder.rust";
      "settings" = {
        "foreground" = "#f5c2e7";
};
}
    {
      "name" = "Rust return type generic";
      "scope" = "meta.function.return-type.rust meta.generic.rust storage.type.rust";
      "settings" = {
        "foreground" = "#cdd6f4";
};
}
    {
      "name" = "Rust functions";
      "scope" = "meta.function.call.rust";
      "settings" = {
        "foreground" = "#89b4fa";
};
}
    {
      "name" = "Rust angle brackets";
      "scope" = "punctuation.brackets.angle.rust";
      "settings" = {
        "foreground" = "#89dceb";
};
}
    {
      "name" = "Rust constants";
      "scope" = "constant.other.caps.rust";
      "settings" = {
        "foreground" = "#fab387";
};
}
    {
      "name" = "Rust function parameters";
      "scope" = [
        "meta.function.definition.rust variable.other.rust"
      ];
      "settings" = {
        "foreground" = "#eba0ac";
};
}
    {
      "name" = "Rust closure variables";
      "scope" = "meta.function.call.rust variable.other.rust";
      "settings" = {
        "foreground" = "#cdd6f4";
};
}
    {
      "name" = "Rust self";
      "scope" = "variable.language.self.rust";
      "settings" = {
        "foreground" = "#f38ba8";
};
}
    {
      "name" = "Rust metavariable names";
      "scope" = [
        "variable.other.metavariable.name.rust"
        "meta.macro.metavariable.rust keyword.operator.macro.dollar.rust"
      ];
      "settings" = {
        "foreground" = "#f5c2e7";
};
}
    {
      "name" = "Shell shebang";
      "scope" = [
        "comment.line.shebang"
        "comment.line.shebang punctuation.definition.comment"
        "comment.line.shebang"
        "punctuation.definition.comment.shebang.shell"
        "meta.shebang.shell"
      ];
      "settings" = {
        "foreground" = "#f5c2e7";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Shell shebang command";
      "scope" = "comment.line.shebang constant.language";
      "settings" = {
        "foreground" = "#94e2d5";
        "fontStyle" = "italic";
};
}
    {
      "name" = "Shell interpolated command";
      "scope" = [
        "meta.function-call.arguments.shell punctuation.definition.variable.shell"
        "meta.function-call.arguments.shell punctuation.section.interpolation"
        "meta.function-call.arguments.shell punctuation.definition.variable.shell"
        "meta.function-call.arguments.shell punctuation.section.interpolation"
      ];
      "settings" = {
        "foreground" = "#f38ba8";
};
}
    {
      "name" = "Shell interpolated command variable";
      "scope" = "meta.string meta.interpolation.parameter.shell variable.other.readwrite";
      "settings" = {
        "foreground" = "#fab387";
        "fontStyle" = "italic";
};
}
    {
      "scope" = [
        "source.shell punctuation.section.interpolation"
        "punctuation.definition.evaluation.backticks.shell"
      ];
      "settings" = {
        "foreground" = "#94e2d5";
};
}
    {
      "name" = "Shell EOF";
      "scope" = "entity.name.tag.heredoc.shell";
      "settings" = {
        "foreground" = "#cba6f7";
};
}
    {
      "name" = "Shell quoted variable";
      "scope" = "string.quoted.double.shell variable.other.normal.shell";
      "settings" = {
        "foreground" = "#cdd6f4";
      };
    }
  ];
  }
