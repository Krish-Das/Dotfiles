#!/usr/bin/env sh

# specify pageId
# add heading level

[ -z "$NOTION_API_TOKEN" ] && {
  printf "\033[41;97m ERROR \033[0m \033[31mNOTION_API_TOKEN is not set\033[0m\n\n"
  exit 1
}

if [ $# -eq 0 ]; then
  printf "\033[41;97m ERROR \033[0m \033[31mNo todo text provided\033[0m\n\n"
  exit 1
fi

todo_text="$*"
page_id="2b9d697da6758013860df4137fe2b2b7"

add_todo() {
  curl -s -o /dev/null -X PATCH "https://api.notion.com/v1/blocks/$page_id/children" \
    -H "Authorization: Bearer $NOTION_API_TOKEN" \
    -H "Content-Type: application/json" \
    -H "Notion-Version: 2022-06-28" \
    --data "$(jq -n --arg text "$todo_text" '{
    children: [
      {
        object: "block",
        type: "to_do",
        to_do: {
          rich_text: [
            {
              type: "text",
              text: { content: $text }
            }
          ],
          checked: false
        }
      }
    ]
  }')"
}
add_todo

printf "\n\e[0;32;1mSUCCESS\n\e[0mAdded new task: \e[0m%s\n\n" "$todo_text"
