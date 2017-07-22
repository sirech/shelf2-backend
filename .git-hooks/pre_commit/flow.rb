module Overcommit::Hook::PreCommit
  class Flow < Base
    def run
      FileUtils.cd 'client' do
        result = execute(command, args: applicable_files)

        begin
          return collect_lint_messages(JSON.parse(result.stdout))
        rescue JSON::ParserError => ex
          return :fail, "Unable to parse JSON returned by flow: #{ex.message}\n" \
                        "STDOUT: #{result.stdout}\nSTDERR: #{result.stderr}"
        end
      end
    end

    private

    def collect_lint_messages(results)
      results['errors'].map do |error|
        severity = :error
        message = error['message']
        loc = message.first['loc']
        formatted = message.map { |m| m['context'] }.compact.join(' ')

        Overcommit::Hook::Message.new(severity, loc['source'], loc['start']['line'], formatted)
      end
    end
  end
end
