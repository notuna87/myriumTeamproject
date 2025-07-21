package com.myrium.controller;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TermsController {

	@Autowired
	private ServletContext servletContext;
	
	@GetMapping("/terms/detail")
	 public String getTermsDetail(@RequestParam("id") int id, Model model) {

        String filename = "/resources/data/terms" + id + ".txt";
        String realPath = servletContext.getRealPath(filename);
        StringBuilder sb = new StringBuilder();

        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(new FileInputStream(realPath), "UTF-8"))) {

            String line;
            boolean firstLine = true;

            while ((line = reader.readLine()) != null) {
                if (firstLine && line.trim().matches("\\[id=\\d+]")) {
                    firstLine = false;
                    continue;
                }
                sb.append(line).append("\n");
                firstLine = false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("termsContent", sb.toString().trim());
        return "join/terms_detail";
	}
}
