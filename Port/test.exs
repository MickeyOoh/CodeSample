cmd = ~S"""
   ruby -e `
     STDOUT.sync = true
     context = binding

     while (cmd = gets) do 
       eval(cmd, context)
     end
  `
"""

