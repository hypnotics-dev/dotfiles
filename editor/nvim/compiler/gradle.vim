" Compiler Plugin for gradle
" TODO Learn how to use autoload to lazy load the script
" TODO java and jUnit errorformat settings should be optional
"      Since gradle can build Java, Kotlin, C++ and so on

let current_compiler = "gradle"

" FIX not enough arguments for escape twice over
execute $'CompilerSet makeprg={escape(get(b:, 'gradle_root'))}gradlew\ {escape(get(b:, 'gradle_makeprg_params', get(g:, 'gradle_makeprg_params', '')), ' \|"')}'

" Error message for POM (Change to Gradle specific)
CompilerSet errorformat=[FATAL]\ Non-parseable\ POM\ %f:\ %m%\\s%\\+@%.%#line\ %l\\,\ column\ %c%.%#,
CompilerSet errorformat+=[%tRROR]\ Malformed\ POM\ %f:\ %m%\\s%\\+@%.%#line\ %l\\,\ column\ %c%.%#

" Stollen from the maven compiler plugin
" These are java and JUnit specific
" Java related build messages
CompilerSet errorformat+=[%tARNING]\ %f:[%l\\,%c]\ %m
CompilerSet errorformat+=[%tRROR]\ %f:[%l\\,%c]\ %m
CompilerSet errorformat+=%A[%t%[A-Z]%#]\ %f:[%l\\,%c]\ %m,%Z
CompilerSet errorformat+=%A%f:[%l\\,%c]\ %m,%Z

" jUnit related build messages
CompilerSet errorformat+=%+E\ \ %#test%m,%Z
CompilerSet errorformat+=%+E[ERROR]\ Please\ refer\ to\ %f\ for\ the\ individual\ test\ results.
" Message from JUnit 5(5.3.X), TestNG(6.14.X), JMockit(1.43), and AssertJ(3.11.X)
CompilerSet errorformat+=%+E%>[ERROR]\ %.%\\+Time\ elapsed:%.%\\+<<<\ FAILURE!,
CompilerSet errorformat+=%+E%>[ERROR]\ %.%\\+Time\ elapsed:%.%\\+<<<\ ERROR!,
CompilerSet errorformat+=%+Z%\\s%#at\ %f(%\\f%\\+:%l),
CompilerSet errorformat+=%+C%.%#

" Misc message removal
CompilerSet errorformat+=%-G[INFO]\ %.%#,
CompilerSet errorformat+=%-G[debug]\ %.%#

