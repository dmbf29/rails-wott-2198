class CreateChallengeTool < RubyLLM::Tool
  description <<~TXT
    Use this tool to create a challenge when the user asks you to.

    After creation, give the link to the challenge to the user. Include the link as a markdown link to that URL: /challenges/{challenge_id}
  TXT

  param :name, desc: "The name of the challenge"
  param :module_name, desc: "The module this challenge belongs to"
  param :content, desc: <<~TXT
    The content of the challenge.

    You should create a custom content based on the user's request, but here is an example of a well formatted content for reference:
    """
    ## Background & Objectives\n\nLet’s keep practicing blocks in this challenge. We will code another method that should be called with a block, and this time we will see how blocks enable nesting method calls, and how this can be useful in a real-life example. We will also discover how we can define methods with a second optional parameter, which happens frequently!\n\n## Specs\n\nImplement the #tag method that builds the HTML tags around the content we give it in the block. For instance:\n```ruby\ntag("h1") do\n  "Some Title"\nend\n#=> "<h1>Some Title</h1>"\n```\n\nThis method accepts a second optional parameter (see section below on arguments with default value), enabling to pass an array with one HTML attribute name and its value, like ["href", "www.google.com"].\n```ruby\ntag("a", ["href", "www.google.com"]) do\n  "Google it"\nend\n#=> '<a href="www.google.com">Google it</a>'\n```\n\nYou may need to know that to include a " symbol inside a string delimited by double quotes,\nyou need to escape this character with an antislash: ".\n\nThe cool thing about this method is that you can nest method calls:\n\n```ruby\ntag("a", ["href", "www.google.com"]) do\n  tag("h1") do\n    "Google it"\n  end\nend\n# => '<a href="www.google.com"><h1>Google it</h1></a>'\n```\n\nCool right?\nArguments with default value\n\nIn Ruby you can supply a default value for an argument. This means that if a value for the argument isn’t supplied, the default value will be used instead, e.g.:\n\n```ruby\ndef sum(a, b, c = 0)\n  return a + b + c\nend\n\nsum(3, 6, 1) # => 10\nsum(4, 2)    # => 6\n```\n\nHere, the third argument is worth 0 if we call sum with only two arguments.\n
    """
  TXT

  def execute(name:, module_name:, content:)
    # Instructions on how to create a challenge

    challenge = Challenge.new(
      name: name,
      module: module_name,
      content: content
    )

    if challenge.save
      { success: true, challenge_id: challenge.id }
    else
      { success: false }
    end
  end
end
