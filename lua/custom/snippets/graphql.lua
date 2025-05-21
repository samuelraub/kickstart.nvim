return {
  -- mutation CreateEntry($input: CreateEntryMutationInput!) {
  --   createEntry(input: $input) {
  --     |
  --   }
  -- }
  s('mu', {
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

  -- query Entries {
  --   entries {
  --     |
  --   }
  -- }
  s('qu', {
    t { 'query ' },
    i(1),
    t { ' {' },
    t { '', '\t' },
    f(function(args)
      local str = args[1][1]
      return string.lower(string.sub(str, 1, 1)) .. string.sub(str, 2)
    end, { 1 }),
    t { ' {' },
    t { '', '\t\t' },
    i(0),
    t { '', '\t}', '}' },
  }),
}
