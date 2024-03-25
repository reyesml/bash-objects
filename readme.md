# Objects in bash

"Bash doesn't support objects." - most people when i ask about this.

Technically, this is correct. Bash _doesn't_ support objects... but we can still make things that kind of look like objects.  That's what this repository is about.

## Some gotchas

This is still bash. All of the rules around scoping remain the same. For example:

- If you mutate object state within a subshell, that state will be lost once the subshell exits. 
- All the functions and variables are globally scoped... they're just not so easy to find due to the random naming convention.
