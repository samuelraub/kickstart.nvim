return {
  s('mut', {
    t { 'mutation ' },
    i(1),
    t { '($input: ' },
    f(function(args)
      return args[1][1] .. 'MutationInput!) {'
    end, { 1 }),
    t { '', '\t' },
    f(function(args)
      local str = args[1][1]
      return string.lower(string.sub(str, 1, 1)) .. string.sub(str, 2)
    end, { 1 }),
    t { '(input: $input) {' },
    t { '', '\t\t' },
    i(0),
    t { '', '\t}', '}' },
  }),
}

-- mutation CreateEntry($input: CreateEntryMutationInput!) {
--   createEntry(input: $input) {
--     |
--   }
-- }
