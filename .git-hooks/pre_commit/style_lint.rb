module Overcommit::Hook::PreCommit
  # Runs `stylelint` against any modified CSS files.
  #
  class StyleLint < Base
    def run
      result = execute(command, args: applicable_files)

      begin
        collect_lint_messages(JSON.parse(result.stdout))
      rescue JSON::ParserError => ex
        return :fail, "Unable to parse JSON returned by stylelint: #{ex.message}\n" \
                      "STDOUT: #{result.stdout}\nSTDERR: #{result.stderr}"
      end
    end

    private

    def collect_lint_messages(results)
      results.flat_map do |file|
        file['warnings'].map do |lint|
          severity = lint['severity'] == 'warning' ? :warning : :error
          path = file['source']
          line = lint['line']
          message = "#{path}:#{line} #{lint['rule']}: #{lint['text']}"

          Overcommit::Hook::Message.new(severity, path, line, message)
        end
      end
    end
  end
end
