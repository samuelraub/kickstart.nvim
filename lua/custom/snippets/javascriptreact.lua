return {

  -- const [foo, setFoo] = useState();
  s('ust', {
    t 'const [',
    i(1),
    t ', set',
    f(function(args)
      local str = args[1][1]
      return string.upper(string.sub(str, 1, 1)) .. string.sub(str, 2)
    end, { 1 }),
    t '] = useState(',
    i(0),
    t ');',
  }),
}
