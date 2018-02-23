/*
 * GameProtocol.swift
 * Project: Space Invaders
 * Students:
 *          Irvinder Kaur           300929258
 *          Kamalpreet Singh        300976062
 *          Mehmet Fatih Inan       300966544
 *          Robert Argume           300949529
 *
 * Date: Mar 22, 2018
 * Description: Establishes methods that every game object should implement
 *              Based on Professor Tom Tsiliopoulos code
 * Version: 0.1
 *     - Basic methods are defined
 */
protocol GameProtocol {
    func Reset()
    
    func CheckBounds()
    
    func Start()
    
    func Update()
}

