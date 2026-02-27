class CreateChallengeTool < RubyLLM::Tool
  description "Use this tool to create a challenge when the user asks you to. After creation, give the link to the challenge. Include the link as a markdown link to that URL: /challenges/{challenge_id}"

  param :name, desc: "This is the name of the challenge"
  param :module_name, desc: "This is the module of the challenge."
  param :content, desc: <<~TXT
    This is the content of the challenge.

    You should create custom content based on the user's request. Here is an example of a well formatted challenge:
    ## Background & Objectives\n\nLet’s continue with our Hacker News app. Today we want to add a user layer, so that you need to log in first before submitting a new post.\n\n(You don’t need to log in to view posts though)\nSetup\n\nWe’ve given you a first migration to create the posts table.\n\n```bash\nrake db:create\nrake db:migrate\n```\n\n## Specs\n\n### Add a User model\n\nWe provide you the basic schema of posts (see existing migration in db/migrate folder).\n\nFirst generate a new migration to create the User model. The model should have the following fields:\n\n```bash\nusername\nemail\n```\n\n### Migration: a User has many posts\n\nGenerate another migration to create a one-to-many reference between User and Post.\n\nMake sure you add the code in your models to allow you to access posts from a user instance, and the user from a given post instance.\n\n### Seed with user and posts\n\nWrite a seed that populates your database with 5 users who each have between 5 and 10 posts. Feel free to use any strategy you want (faker or API).\n\nDon’t spend too much time trying to use the API. Remember that our goal here is to work with associations.
  TXT

  # create an instance of a challenge
  def execute(name:, content:, module_name:)
    challenge = Challenge.new(
      name: name,
      content: content,
      module: module_name
    )
    if challenge.save
      # who are we returning to?
      { success: true, challenge_id: challenge.id }
    else
      { success: false, errors: challenge.errors.messages }
    end
  end
end
