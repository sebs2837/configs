return {
    s("println", fmt([[println!("{}"{});]], {
        i(1, "print statement"),
        c(2, {
            fmt([[,{var}]], { var = i(1, "variable name") }),
            t(""),
        })
    })),
    s(":turbo", { t("::<"), i(1, "type"), t(">") }),
    s("event",
        fmt([[event!({},"{}");]], {
            c(1, {
                t("Level::INFO"),
                t("Level::WARN"),
                t("Level::ERROR"),
                t("Level::DEBUG"),
                t("Level::TRACE"),
            }),
            i(2, "event message")
        })),
    s("log", fmt([[{}("{}"{});]], {
        c(1, {
            t("info!"),
            t("warn!"),
            t("err!"),
            t("debug!"),
            t("trace!"),
        }),
        i(2, "log message"),
        c(3, {
            t(",{}", { i(1, "variable") }),
            t("")
        })
    })),
    s("ifle", fmt([[
    if let <var> = <expr>  {
        <body>
    };
    ]], {
        var = c(1, {
            fmt([[Some({var})]], { var = i(1, "variable") }),
            fmt([[Ok({var})]], { var = i(1, "variable") }),
        }),
        expr = i(2, "expression"),
        body = i(3, "body"),
    }, { delimiters = "<>" })),
    s("tst", fmt([[
    #[cfg(test)]
    mod test {
        <>
        #[test]
        fn <>(){
        }
    }
    ]], {
        c(1, {
            t("use super::*;"),
            t(""),
        }),
        i(2, "function_name"),
    },{delimiters = "<>"}
    ))
}
