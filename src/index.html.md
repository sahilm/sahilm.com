---
title: Hello World
---

<div class="post">
It is a fact universally acknowledged that every time a member of a political party is criticized by members of their own party, the Internet will get very excited and angry. Don’t they understand that this threatens their own party’s future? some yell, while Don’t they understand that this person is betraying the party? is yelled back — and quickly things escalate and lead to long-simmering grudges which may at first seem odd.
</div> 

<div class="post">
It is a fact universally acknowledged that every time a member of a political party is criticized by members of their own party, the Internet will get very excited and angry. Don’t they understand that this threatens their own party’s future? some yell, while Don’t they understand that this person is betraying the party? is yelled back — and quickly things escalate and lead to long-simmering grudges which may at first seem odd.
</div>

```go
func crawl(url string, depth int, fetcher Fetcher, visited *concurrent.Map, pages *concurrent.Slice, errors *concurrent.Slice) {
	// We've reached max depth. Time to bail.
	if depth <= 0 {
		return
	}
	// The intention is to claim the url for this goroutine.
	// If someone else has already claimed it, we'll just exit.
	_, ok := visited.PutIfAbsent(url, sentinel)
	if !ok {
		return
	}
	page, err := fetcher.Fetch(url)
	if err != nil {
		errors.Append(err)
		return
	}
	pages.Append(page)
	done := make(chan bool)
	// Spawn as many goroutines as links on the page.
	for _, url := range page.Links {
		go func(url string) {
			crawl(url, depth-1, fetcher, visited, pages, errors)
			done <- true
		}(url)
	}
	// Wait for all of them to finish.
	for range page.Links {
		<-done
	}
	// We're done crawling this page. On to the next!
}
```

<div class="post">
It is a fact universally acknowledged that every time a member of a political party is criticized by members of their own party, the Internet will get very excited and angry. Don’t they understand that this threatens their own party’s future? some yell, while Don’t they understand that this person is betraying the party? is yelled back — and quickly things escalate and lead to long-simmering grudges which may at first seem odd.
</div>
