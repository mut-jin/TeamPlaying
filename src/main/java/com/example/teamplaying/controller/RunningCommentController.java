package com.example.teamplaying.controller;

import com.example.teamplaying.domain.RunningComment;
import com.example.teamplaying.service.RunningCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("runningComment")
public class RunningCommentController {

	@Autowired
	private RunningCommentService service;

	@PutMapping("update")
	@PreAuthorize("authenticated")
	public ResponseEntity<Map<String, Object>> update(@RequestBody RunningComment comment) {
		
		Map<String, Object> res = service.update(comment);
		

		return ResponseEntity.ok().body(res);
	}

	@GetMapping("id/{id}")
	public RunningComment get(@PathVariable("id") Integer id) {
		return service.get(id);
	}

	@PostMapping("add")
	@PreAuthorize("authenticated")
	public ResponseEntity<Map<String, Object>> add(@RequestBody RunningComment comment, Authentication authentication) {

		if (authentication == null) {
			Map<String, Object> res = Map.of("message", "로그인 후 댓글을 작성해주세요");
			return ResponseEntity.status(401).body(res);
		} else {
			Map<String, Object> res = service.add(comment, authentication);
			return ResponseEntity.ok().body(res);
		}

	}

	@GetMapping("list")
	public List<RunningComment> list(@RequestParam("board") Integer boardId, Authentication authentication) {

		return service.list(boardId, authentication);
	}

	@DeleteMapping("id/{id}")
	@PreAuthorize("authenticated")
	public ResponseEntity<Map<String, Object>> remove(@PathVariable("id") Integer id) {
		Map<String, Object> res = service.remove(id);

		return ResponseEntity.ok().body(res);
	}

}
