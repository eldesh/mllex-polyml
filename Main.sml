(* Copyright (C) 2020 Takayuki Goto.
 *
 * MLLex-Poly/ML is imported from MLton.
 * See the LICENSE file for details.
 *)

structure Main =
struct

fun usage s =
  raise Fail (concat[s, "\n", "Usage: ", CommandLine.name(), " ", "file.lex ..."])

fun main args =
  if null args then
    usage "no files"
  else
    List.app LexGen.lexGen args

val main = fn () => (
    main (CommandLine.arguments());
    OS.Process.exit OS.Process.success
  ) handle Fail msg => (
    print(concat["Fail: ", msg, "\n"]);
    OS.Process.exit OS.Process.failure
  ) handle exn => (
    print(concat[exnMessage exn, "\n"]);
    OS.Process.exit OS.Process.failure
  )
end
