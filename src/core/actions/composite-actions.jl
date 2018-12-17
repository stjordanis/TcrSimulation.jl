
function challenge(registry, agents, deposit, voteFunc, redistributionFunc)
    if (length(registry) >= 10)
        challenger = agents[rand(1:end)]
        evaluations = evaluateCandidateByAgent.(registry, challenger)
        challengedIndex = indmin(evaluations);
        challengedValue = evaluations[challengedIndex]

        # if (min < mean(registry))
            challenger.balance -= deposit

            votingResult = voteFunc(registryMean(registry), challengedValue, agents)
            if (!votingResult[1])
                deleteat!(registry, challengedIndex)
            end
            redistributionFunc(votingResult, challenger, deposit)
        # end
    end
end

function application(registry, history, agents, voteFunc)
    candidate = getRegistryCandidate()
    push!(history, candidate)
    # println("Candidate: $candidate")
    if voteFunc(registryMean(registry), candidate, agents)[1]
        push!(registry, candidate);
    end
end
