#!/usr/bin/env bash
set -uo pipefail

# This preflight script is run to check the following -
# 1. That all required binaries are present
# 2. Checks the version of ollama
# 3. Checks to make sure recommended LLMs are downloaded

# Hardcode list of binaries to ensure are present
_REQUIRED_BINARIES=("ollama" "python3")

OLLAMA_MIN_REQUIRED_VERSION=0.6.8

OLLAMA_DRAMA_RECOMMENDED_LLMS=("qwen3#0.6b#7df6b6e09427")
#OLLAMA_DRAMA_RECOMMENDED_LLMS=("qwen3#0.6b#7df6b6e09427" "qwen3#1.7b#8f68893c685c" "qwen3#4b#a383baf4993b" "qwen3#8b#e4b5fd7f8af0")

PREFLIGHT_ERROR_CHECK=0
PREFLIGHT_WARN_CHECK=0

PREFLIGHT_SUGGEST_TO_PULL_LLMS=0
LLMS_TO_PULL=()

if [[ -z "${PREFLIGHT_OVERRIDE+x}" ]]; then
  PREFLIGHT_OVERRIDE=0
fi

# Detect Operating System (Linux/Darwin supported)
OS=$(uname -s)

check_required_binaries() {
    CURRENT_CHECK_FAILED=0

    for binary in "${_REQUIRED_BINARIES[@]}"; do
        if ! command -v "${binary}" >/dev/null 2>&1; then
            echo "❌ ${binary} is not installed"
            echo "Please install ${binary} and try again."
            CURRENT_CHECK_FAILED=1
        fi
    done

    if [[ "$CURRENT_CHECK_FAILED" -eq "0" ]]; then
        echo "INFO: ✅ All required binaries are present 🦙"
    else
        PREFLIGHT_ERROR_CHECK=1
    fi

}

check_ollama_version() {
    CURRENT_CHECK_FAILED=0
    version=$(ollama --version | awk '{ print $4 }') || {
        echo "❌ ollama binary not found or failed to parse version"
        echo "Please install ollama and try again"
        CURRENT_CHECK_FAILED=1
    }
    if [[ "$CURRENT_CHECK_FAILED" -eq 0 ]]; then
        if [[ "$(printf '%s\n' "$OLLAMA_MIN_REQUIRED_VERSION" "$version" | sort -V | head -n1)" != "$OLLAMA_MIN_REQUIRED_VERSION" ]]; then
            echo "❌ ollama needs to be at least $OLLAMA_MIN_REQUIRED_VERSION, found $version"
            CURRENT_CHECK_FAILED=1
        fi
    fi
    if [[ "$CURRENT_CHECK_FAILED" -eq 0 ]]; then
        echo "INFO: ✅ ollama version $version satisfies minimum $OLLAMA_MIN_REQUIRED_VERSION 🦙"
    else
        PREFLIGHT_ERROR_CHECK=1
    fi
}

check_recommended_ollama_drama_llms() {
    CURRENT_CHECK_WARN=0

    for llm in "${OLLAMA_DRAMA_RECOMMENDED_LLMS[@]}"; do

        recommended_llm_name=$(echo $llm | cut -d# -f1)
        recommended_llm_tag=$(echo $llm | cut -d# -f2)
        recommended_llm_hash=$(echo $llm | cut -d# -f3)

        FOUND_LLM_MIN=0

        IFS=$'\n'
        for llm_line in $(ollama list | grep "$recommended_llm_name" | grep "$recommended_llm_tag"); do
            llm_name_colon_tag=$(echo $llm_line | awk '{ print $1 }')
            llm_hash=$(echo $llm_line | awk '{ print $2 }')

            if [[ "$FOUND_LLM_MIN" -ne "1" && "$llm_name_colon_tag" == "$recommended_llm_name:$recommended_llm_tag" ]]; then
                echo "INFO: ✅ HASH $llm_hash for LLM $llm_name_colon_tag found to satisfy recommended version of $recommended_llm_name with tag $recommended_llm_tag 🦙"
                FOUND_LLM_MIN=1
            fi
        done
        unset IFS

        if [[ "$FOUND_LLM_MIN" -ne "1" ]]; then
            echo "WARN: ⚠️  RECOMMENDED LLM $recommended_llm_name WITH TAG $recommended_llm_tag IS NOT FOUND IN ollama list 🦙"
            CURRENT_CHECK_WARN=1
            PREFLIGHT_SUGGEST_TO_PULL_LLMS=1
            LLMS_TO_PULL+=("$recommended_llm_name:$recommended_llm_tag")
        fi

    done

    if [[ "$CURRENT_CHECK_WARN" -eq "0" ]]; then
        echo "INFO: ✅ All recommended LLMs are wrangled and accounted for 🦙"
    else
        PREFLIGHT_WARN_CHECK=1
    fi
}

echo "✈️  STARTING OLLAMA DRAMA PREFLIGHT CHECKS 🦙"
echo "INFO: 🦙 Checking if required binaries exist"
check_required_binaries

echo "INFO: 🦙 Checking if ollama version is at least $OLLAMA_MIN_REQUIRED_VERSION"
check_ollama_version

echo "INFO: 🦙 Checking if recommended LLMs for Ollama Drama have been downloaded"
check_recommended_ollama_drama_llms

if [[ $PREFLIGHT_ERROR_CHECK -eq 0 && $PREFLIGHT_WARN_CHECK -eq 0 ]]; then
    echo "🚀 ALL PREFLIGHT CHECKS COMPLETED SUCCESSFULLY NO DRAMA EXPECTED 🦙"
elif [[ $PREFLIGHT_ERROR_CHECK -eq 0 ]]; then
    echo "🚀 ALL REQUIRED CHECKS COMPLETED SUCCESSFULLY 🦙"
    echo "⚠️  RECOMMENDED CHECKS FAILED EXPECT PARTIAL FUNCTIONALITY AND SOME DRAMA 🦙"
    echo "🦙 CHECK PREFLIGHT OUTPUT FOR DETAILS 🦙"
    if [[ ${#LLMS_TO_PULL[@]} -gt 0 ]]; then
        echo "🦙 ASKING IF USER WOULD LIKE TO PULL THE RECOMMENDED LLMS 🦙"
        echo "❓ Would you like to pull the recommended LLMs '${LLMS_TO_PULL[@]}' at this point?"
        read -p "🦙 ⤵️  (Y/[N]): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
        for llm_to_pull in "${LLMS_TO_PULL[@]}"; do
            echo "🦙 pulling $llm_to_pull"
            echo "ollama pull $llm_to_pull"
            ollama pull "$llm_to_pull"
        done
    fi
else
    echo "❌ PREFLIGHT CHECKS FAILED"
    if [[ $PREFLIGHT_OVERRIDE -eq 1 ]]; then
        echo "⚠️  ⚠️  ⚠️  PREFLIGHT_OVERRIDE DETECTED ⚠️  ⚠️  ⚠️  IGNORING FAILED CHECKS AND PROCEEDING 🚀 🦙 ⚠️  ⚠️  ⚠️"
        echo "🦙 🦙 🦙 HIGH LEVELS OF DRAMA DETECTED 🦙 🦙 🦙"
        exit 0
    else
        exit $PREFLIGHT_ERROR_CHECK
    fi

fi
